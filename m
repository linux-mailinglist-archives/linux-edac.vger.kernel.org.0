Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545E84F6DE1
	for <lists+linux-edac@lfdr.de>; Thu,  7 Apr 2022 00:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiDFWkb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 18:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiDFWka (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Apr 2022 18:40:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A6A1928A;
        Wed,  6 Apr 2022 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649284712; x=1680820712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cjtx56urfcl65Nbxp0gNQfOnI14k9WmRegTAhY8jDjE=;
  b=huKNO56PJFJOcs4YeC/oNy+K+74X6Jf0NYVR1fgeKW0F4lR29dZ3j757
   cI5b+1UWvdTEm7EeOfhIoDBXBSW3dX6SPVQUITpT6i44pmTBP3qhfs34a
   MBBAOk+n/fIn7Lb9bTnsRaDyl/WG0wNtIoo2rjApA2MNqq7g0uq94T2Wk
   lmQr1XXauAXSvBFYUbW49KQd9s7fmHpAtoOyR+3PjOqRpenOmgqHqN3VI
   4rCpeSLiNrGNF+rJsdz19D8OXk1yupgwlbvaFnU3jqWL940FYtrz/cG7F
   6ibLRcnuRF6rOCaQ1ELMnQynwAKRWklZvXtkdNmFHXaHUJqY6bRtTXrU3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241101939"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="241101939"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 15:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="722699716"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2022 15:38:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 15:38:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 15:38:31 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Wed, 6 Apr 2022 15:38:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "Borislav Petkov" <bp@alien8.de>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 3/5] x86/mce: Introduce a function pointer
 mce_handle_storm
Thread-Topic: [RFC PATCH 3/5] x86/mce: Introduce a function pointer
 mce_handle_storm
Thread-Index: AQHYSYCbmdtpU5l4YUOkIK8b/jgkFqzjeaRg
Date:   Wed, 6 Apr 2022 22:38:30 +0000
Message-ID: <34f2279e49e04761acd273ec4e54e062@intel.com>
References: <20220406063542.183946-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220406063542.183946-4-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20220406063542.183946-4-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Introduce a function pointer "mce_handle_storm". This function pointer
> does the vendor specific storm handling. In Intel it points to a routine
> to set different thresholds in IA32_MCi_CTL2.

Boris did some cleanups in machine check code to get rid of places
where function pointers were used. E.g.

cc466666ab09 x86/mce: Get rid of the ->quirk_no_way_out() indirect call
8121b8f947be x86/mce: Get rid of msr_ops
cbe1de162d82 x86/mce: Get rid of machine_check_vector
631adc7b0bba x86/mce: Get rid of the mce_severity function pointer

Was that to help with the "noinstr" cleanup?  I'm not sure if that
would apply here (in which case mce_handle_storm would be
a regular function with a switch on "vendor".)

-Tony
