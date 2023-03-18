Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC96BF745
	for <lists+linux-edac@lfdr.de>; Sat, 18 Mar 2023 02:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCRBse (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Mar 2023 21:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRBsd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Mar 2023 21:48:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1426D3C786;
        Fri, 17 Mar 2023 18:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679104112; x=1710640112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZEIyleGGb8UU0vqHVOdtpSNb6wHhAr0V3A6sC6d3dGc=;
  b=Fe3vnq4UCZXq+Gy11EqZ1pwFkwwHnh9CYeJFOwYDfv06oH1WGHMUQc9q
   PCapGkPACDbP4J1okhyZc8NcKatxLlGAr3whGwLOdzt5Z9OcempwMrr+G
   NGxoQAcMMOrgAXllmTrUhClHoHRvl0SaXqy1BZ2NElRQL5BQ/oYJjQmbH
   d0Emwln9IA8BvEKbLh4ocg5cxnftiGJx3c/ylLVJtbEw6ZZJis5A7cVNu
   lsVH0ta0TtGTI0aAXe1GuZI1ODBweCYnZ8aQud7ZdY/kMmwutQsXzEz/R
   OYzNcOk36I4A1iCqnxyOS1q58SsNnddiMSHJAj5TtTB+K3qAp+W+5cgUC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="338416570"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="338416570"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 18:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="680484443"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="680484443"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 Mar 2023 18:48:28 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdLgJ-0009io-2m;
        Sat, 18 Mar 2023 01:48:27 +0000
Date:   Sat, 18 Mar 2023 09:48:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        linux-edac@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, git@amd.com,
        devicetree@vger.kernel.org, bp@alien8.de,
        krzysztof.kozlowski@linaro.org, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        michal.simek@xilinx.com
Subject: Re: [PATCH v4 2/2] edac/xilinx: Add EDAC support for Xilinx DDR
 controller
Message-ID: <202303180902.boahuY9A-lkp@intel.com>
References: <20230317140425.16827-3-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317140425.16827-3-shubhrajyoti.datta@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Shubhrajyoti,

I love your patch! Yet something to improve:

[auto build test ERROR on v6.2]
[cannot apply to ras/edac-for-next linus/master v6.3-rc2 v6.3-rc1 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shubhrajyoti-Datta/dt-bindings-edac-Add-support-for-Xilinx-Versal-EDAC-DDRMC/20230317-220620
patch link:    https://lore.kernel.org/r/20230317140425.16827-3-shubhrajyoti.datta%40amd.com
patch subject: [PATCH v4 2/2] edac/xilinx: Add EDAC support for Xilinx DDR controller
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230318/202303180902.boahuY9A-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e559cd43b0a69ecf03e6f571f85953dbf8186549
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shubhrajyoti-Datta/dt-bindings-edac-Add-support-for-Xilinx-Versal-EDAC-DDRMC/20230317-220620
        git checkout e559cd43b0a69ecf03e6f571f85953dbf8186549
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303180902.boahuY9A-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/edac/versal_edac.c: In function 'setup_column_address_map':
>> drivers/edac/versal_edac.c:852:38: error: 'COL_0_MASK' undeclared (first use in this function); did you mean 'CH_0_MASK'?
     852 |         priv->col_bit[0] = FIELD_GET(COL_0_MASK, regval);
         |                                      ^~~~~~~~~~
   include/linux/compiler_types.h:338:23: note: in definition of macro '__compiletime_assert'
     338 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/edac/versal_edac.c:852:28: note: in expansion of macro 'FIELD_GET'
     852 |         priv->col_bit[0] = FIELD_GET(COL_0_MASK, regval);
         |                            ^~~~~~~~~
   drivers/edac/versal_edac.c:852:38: note: each undeclared identifier is reported only once for each function it appears in
     852 |         priv->col_bit[0] = FIELD_GET(COL_0_MASK, regval);
         |                                      ^~~~~~~~~~
   include/linux/compiler_types.h:338:23: note: in definition of macro '__compiletime_assert'
     338 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/edac/versal_edac.c:852:28: note: in expansion of macro 'FIELD_GET'
     852 |         priv->col_bit[0] = FIELD_GET(COL_0_MASK, regval);
         |                            ^~~~~~~~~


vim +852 drivers/edac/versal_edac.c

   845	
   846	static void setup_column_address_map(struct edac_priv *priv)
   847	{
   848		u32 regval;
   849		union edac_info cols;
   850	
   851		regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC8_OFFSET);
 > 852		priv->col_bit[0] = FIELD_GET(COL_0_MASK, regval);
   853	
   854		regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC9_OFFSET);
   855		cols.i  = regval;
   856		priv->col_bit[1] = cols.col1;
   857		priv->col_bit[2] = cols.col2;
   858		priv->col_bit[3] = cols.col3;
   859		priv->col_bit[4] = cols.col4;
   860		priv->col_bit[5] = cols.col5;
   861	
   862		regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC10_OFFSET);
   863		cols.i  = regval;
   864		priv->col_bit[6] = cols.col1;
   865		priv->col_bit[7] = cols.col2;
   866		priv->col_bit[8] = cols.col3;
   867		priv->col_bit[9] = cols.col4;
   868	}
   869	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
