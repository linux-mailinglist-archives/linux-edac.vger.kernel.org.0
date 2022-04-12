Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBA74FC933
	for <lists+linux-edac@lfdr.de>; Tue, 12 Apr 2022 02:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbiDLAXU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Apr 2022 20:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiDLAXT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Apr 2022 20:23:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFC51A398;
        Mon, 11 Apr 2022 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649722864; x=1681258864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+zTTy5CI3GNREFYc9JiyGvGn07qob/vUmhtZhp7lmTw=;
  b=LydNbj98joDFMwwyZWpAm5jq65jvxX/IcmdAUDir3EZzzR2BE/qgbrYF
   QGxKTp75cHCqunbx2B8IeFsMs/ytpadg+2+MFcXd+MEqO8noG/y8uLmD4
   I19JBV02lCeC1Vj/mzlA7AV+EceGkeBEEhlCs2sSXfHgVaWoV2kPGzhXd
   4kEHzO+jD1aP693nMiXIuYOBDW9gyM17Vk9J6HHI31luwXXrH72kBUevF
   d2Kp71BuZdGM29otycv5M+uv0OE0fm1wBzvfoFHqxoyXDGWp+41WWfN8j
   vtusK/NIBkMrYbIRyRGsu2fgtGOKSts9dt7WuwEDppMLptudBR85lF+aK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262424756"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="262424756"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="699598696"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2022 17:21:01 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne4HE-0002MG-OX;
        Tue, 12 Apr 2022 00:21:00 +0000
Date:   Tue, 12 Apr 2022 08:20:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Priyanka Singh <priyanka.singh@nxp.com>, york.sun@nxp.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     kbuild-all@lists.01.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, priyanka.jain@nxp.com,
        jaiprakash.singh@nxp.com, rajan.gupta@nxp.com,
        rajesh.bhagat@nxp.com, Priyanka Singh <priyanka.singh@nxp.com>
Subject: Re: [PATCH 1/1] drivers: edac: Fix bad bit shift operations
Message-ID: <202204120819.tHnMbFil-lkp@intel.com>
References: <20220411105159.10746-1-priyanka.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411105159.10746-1-priyanka.singh@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Priyanka,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Priyanka-Singh/drivers-edac-Fix-bad-bit-shift-operations/20220411-190157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220412/202204120819.tHnMbFil-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c686e26cdea24d78450aaaff268558ea6842cd31
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Priyanka-Singh/drivers-edac-Fix-bad-bit-shift-operations/20220411-190157
        git checkout c686e26cdea24d78450aaaff268558ea6842cd31
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/bug.h:5,
                    from arch/arm64/include/asm/cpufeature.h:19,
                    from arch/arm64/include/asm/hwcap.h:9,
                    from arch/arm64/include/asm/arch_timer.h:12,
                    from arch/arm64/include/asm/timex.h:8,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from arch/arm64/include/asm/stat.h:12,
                    from include/linux/stat.h:6,
                    from include/linux/module.h:13,
                    from drivers/edac/fsl_ddr_edac.c:17:
   drivers/edac/fsl_ddr_edac.c: In function 'fsl_mc_check':
>> include/linux/kern_levels.h:5:25: warning: too many arguments for format [-Wformat-extra-args]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   drivers/edac/edac_mc.h:55:9: note: in expansion of macro 'printk'
      55 |         printk(level "EDAC " prefix " MC%d: " fmt, mci->mc_idx, ##arg)
         |         ^~~~~~
   drivers/edac/fsl_ddr_edac.h:20:9: note: in expansion of macro 'edac_mc_chipset_printk'
      20 |         edac_mc_chipset_printk(mci, level, "FSL_DDR", fmt, ##arg)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/edac/fsl_ddr_edac.c:350:25: note: in expansion of macro 'fsl_mc_printk'
     350 |                         fsl_mc_printk(mci, KERN_ERR,
         |                         ^~~~~~~~~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   drivers/edac/fsl_ddr_edac.c:350:44: note: in expansion of macro 'KERN_ERR'
     350 |                         fsl_mc_printk(mci, KERN_ERR,
         |                                            ^~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
