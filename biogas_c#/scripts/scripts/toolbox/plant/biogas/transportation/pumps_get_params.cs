﻿/**
 * This file is part of the partial class pumps and defines
 * public get_params_of methods.
 * 
 * TODOs:
 * - 
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using toolbox;
using science;

/**
 * Mainly everything that has to do with biogas is defined in this namespace:
 * 
 * - Anaerobic Digestion Model
 * - CHPs
 * - Digesters
 * - Plant
 * - Substrates
 * - Chemistry used for biogas stuff
 * 
 */
namespace biogas
{
  /// <summary>
  /// list of pumps
  /// 
  /// contains all pumps that are included inside the simulation model
  /// 
  /// next to pumps there also could be other transportation objects
  /// inside the model, see the other class
  /// </summary>
  public partial class pumps : List<pump>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Get a string param of the by index specified pump. index is 1-based.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <param name="symbol">parameter</param>
    /// <returns>string</returns>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(int index, string symbol)
    {
      if (index <= 0 || index > getNumPumps())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumPumps()));

      return this[index - 1].get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by index specified pump. index is 1-based.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <param name="symbol">parameter</param>
    /// <returns>double</returns>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(int index, string symbol)
    {
      if (index <= 0 || index > getNumPumps())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumPumps()));

      return this[index - 1].get_param_of_d(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by index specified pump. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index">pump index</param>
    /// <param name="symbol">parameter</param>
    /// <returns>double</returns>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of(int index, string symbol)
    {
      if (index <= 0 || index > getNumPumps())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumPumps()));

      return this[index - 1].get_param_of(symbol);
    }

    /// <summary>
    /// Get a string param of the by id specified pump.
    /// </summary>
    /// <param name="id">id of pump</param>
    /// <param name="symbol">parameter</param>
    /// <returns>string</returns>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(string id, string symbol)
    {
      return get(id).get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by id specified pump.
    /// </summary>
    /// <param name="id">id of pump</param>
    /// <param name="symbol">parameter</param>
    /// <returns>double</returns>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(string id, string symbol)
    {
      return get(id).get_param_of_d(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by id specified pump.
    /// </summary>
    /// <param name="id">id of pump</param>
    /// <param name="symbol">parameter</param>
    /// <returns>double</returns>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of(string id, string symbol)
    {
      return get(id).get_param_of(symbol);
    }


    
  }
}


