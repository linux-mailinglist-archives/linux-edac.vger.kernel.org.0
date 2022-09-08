Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A095B1377
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 06:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIHEWh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 00:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiIHEWT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 00:22:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6826C75;
        Wed,  7 Sep 2022 21:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662610915; x=1694146915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X09slTsSQ7VnMYNmF84pcS2pMwdZUlN6Ob95RIFK5K8=;
  b=UiEOl0JLw3J9BYfK4gqh0nuE1xMlLYMhf3LJwl90tAQMdLLimaxTluDv
   C23DG28qIsvxf5UBddNAuFnkfdZSaBNUmWPUNTDFZIwRtGQZqwnT9DRwp
   NmSSvWkjluRgegKI7bK+sxJj8+68CPOsWWlbfEfsm3JGykNA7JyOVJTLg
   JiTxzkCIRxQbRt9G+lkKmOz+njpaGi3HeJctDV9yZYDH2iZhUiZ1Zzgjn
   dllis9CpQVdb4vX1faA5GQ1/mAgy+djXuuLySqHIffu2aNd5H2CmJHLBt
   Kkq2hcsy4h+djsFsIaYCYMOEOj+bVjTerJoYBpfmRg0KfxeTEirduTdyr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="277452796"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="277452796"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 21:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="614739377"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2022 21:21:51 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW930-0007M9-1W;
        Thu, 08 Sep 2022 04:21:50 +0000
Date:   Thu, 8 Sep 2022 12:21:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        saikrishna12468@gmail.com, git@amd.com,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH v4 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Message-ID: <202209081225.5YuFsgGp-lkp@intel.com>
References: <20220907111531.703-3-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907111531.703-3-sai.krishna.potthuri@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Sai,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on ras/edac-for-next krzk-dt/for-next linus/master v6.0-rc4 next-20220907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sai-Krishna-Potthuri/edac-Add-support-for-Xilinx-ZynqMP-OCM-EDAC/20220907-191854
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/038e95811e4eddd23a098d0faf7a90bbccdb6e52
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sai-Krishna-Potthuri/edac-Add-support-for-Xilinx-ZynqMP-OCM-EDAC/20220907-191854
        git checkout 038e95811e4eddd23a098d0faf7a90bbccdb6e52
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
