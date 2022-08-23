Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13359EFD4
	for <lists+linux-edac@lfdr.de>; Wed, 24 Aug 2022 01:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiHWXno (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 19:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHWXnn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 19:43:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB60895E3;
        Tue, 23 Aug 2022 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661298222; x=1692834222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MCO4VTWPjr/7LqzHSAIUYtAKtbbOGlRNQ96nMCvQHG4=;
  b=bt5fKKYtUbUJ2Wr3CiozvcZgbEi+r/VwnlKIulrFOG4RfJ6FKbFpDAUH
   DVGPJYij6DPRdFfE3qz02UNrMp57MT927WyOvEYlKoBDpvK1sBPgwCmuA
   yyUaP1mRFHp7ww2dfTsx3VkHzy4toyy+MycZ5BQgaQ4uTdj18zcY2i/uS
   xQCafWZE4awRwimL16zB8k0JFIcIeG1zkkmbM09GjC//O4at2qsSEYEyt
   C4/Rv2C9+fJ9SMxC8KTyc8n977YaWP4mqWLFl5/0dXTgqrvwN24czzGk3
   M3eJEnHvIOf/6gb47Yy2ptld9Y973bFd0ndGuwevCsuOcF7RYbfnXkcKI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294609159"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="294609159"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 16:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="677813040"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2022 16:43:11 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQdY6-0000ia-1Z;
        Tue, 23 Aug 2022 23:43:10 +0000
Date:   Wed, 24 Aug 2022 07:42:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/20] EDAC/synopsys: Drop unused platform-specific setup
 API
Message-ID: <202208240709.CwTZS8Qo-lkp@intel.com>
References: <20220822190730.27277-19-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822190730.27277-19-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Serge,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on robh/for-next linus/master v6.0-rc2 next-20220823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/EDAC-mc-synopsys-Various-fixes-and-cleanups/20220823-031020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
config: arm-buildonly-randconfig-r006-20220823 (https://download.01.org/0day-ci/archive/20220824/202208240709.CwTZS8Qo-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ec4a1d5280959bf5c6ff8d63006c62d54e01f9cc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/EDAC-mc-synopsys-Various-fixes-and-cleanups/20220823-031020
        git checkout ec4a1d5280959bf5c6ff8d63006c62d54e01f9cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/edac/synopsys_edac.c: In function 'synps_get_dtype':
   drivers/edac/synopsys_edac.c:485:18: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     485 |         regval = FIELD_GET(DDR_MSTR_DEV_CFG_MASK, regval);
         |                  ^~~~~~~~~
         |                  FOLL_GET
   drivers/edac/synopsys_edac.c: In function 'mc_init':
>> drivers/edac/synopsys_edac.c:600:33: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
     600 |         struct synps_edac_priv *priv;
         |                                 ^~~~
   cc1: some warnings being treated as errors


vim +/priv +600 drivers/edac/synopsys_edac.c

ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  588  
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  589  /**
225af74d6312b2a Manish Narani             2018-10-04  590   * mc_init - Initialize one driver instance.
225af74d6312b2a Manish Narani             2018-10-04  591   * @mci:	EDAC memory controller instance.
225af74d6312b2a Manish Narani             2018-10-04  592   * @pdev:	platform device.
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  593   *
225af74d6312b2a Manish Narani             2018-10-04  594   * Perform initialization of the EDAC memory controller instance and
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  595   * related driver-private data associated with the memory controller the
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  596   * instance is bound to.
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  597   */
fa9f6b9e1cf9620 Manish Narani             2018-10-04  598  static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  599  {
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06 @600  	struct synps_edac_priv *priv;
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  601  
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  602  	mci->pdev = &pdev->dev;
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  603  	priv = mci->pvt_info;
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  604  	platform_set_drvdata(pdev, mci);
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  605  
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  606  	/* Initialize controller capabilities and configuration */
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  607  	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  608  	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
5cfa57cc8481722 Serge Semin               2022-08-22  609  	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  610  	mci->scrub_mode = SCRUB_NONE;
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  611  
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  612  	mci->edac_cap = EDAC_FLAG_SECDED;
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  613  	mci->ctl_name = "synps_ddr_controller";
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  614  	mci->dev_name = SYNPS_EDAC_MOD_STRING;
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  615  	mci->mod_name = SYNPS_EDAC_MOD_VER;
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  616  
b500b4a029d577c Manish Narani             2018-10-25  617  	edac_op_state = EDAC_OPSTATE_INT;
b500b4a029d577c Manish Narani             2018-10-25  618  
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  619  	mci->ctl_page_to_phys = NULL;
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  620  
fa9f6b9e1cf9620 Manish Narani             2018-10-04  621  	init_csrows(mci);
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  622  }
ae9b56e3996dadb Punnaiah Choudary Kalluri 2015-01-06  623  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
