Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCE34F6DF2
	for <lists+linux-edac@lfdr.de>; Thu,  7 Apr 2022 00:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbiDFWqR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 18:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbiDFWqO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Apr 2022 18:46:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7C197FAA;
        Wed,  6 Apr 2022 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649285055; x=1680821055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BXHlXRs9Y//4ncXgZx8BFrLclVb5x0WXnhH88lhKkU4=;
  b=API4CzNDSVLZ8xAQlejPFwZqYexeeQ6g+91/GqpCYqcw6ucpSG4pmII0
   whhpXrp5b7Kbe621GUfrhfMAaOP2osIWcixlbOYtToj/xd1Hi7YjfhXY1
   rIalaUBANjwIXHpNNGjEGrQQ0y/DUn0a47pTZKpczyvoDFYQIk6h4F8Ve
   FG607Vxxv3O38HPPdR5NWPnVRfKnA9K+oD5gROc+0VLXe/k83WCcizrH1
   NxjkyMPd/SX/anKBcPSWayzzbBGbiI+9czUSKtSZ/Ur3yEtxW7dFMETxB
   tj16LFFjhfQTPRrqzVhzFZNh314yfzLmCaRAT4xh78vWhvMRmKVb/cizw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="260007582"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="260007582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 15:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="570770448"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 06 Apr 2022 15:44:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 15:44:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 15:44:13 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Wed, 6 Apr 2022 15:44:13 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "Borislav Petkov" <bp@alien8.de>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 5/5] x86/mce: Handle AMD threshold interrupt storms
Thread-Topic: [RFC PATCH 5/5] x86/mce: Handle AMD threshold interrupt storms
Thread-Index: AQHYSYCbSvicE54JgU2PntMI6Ix4HKzje9Lg
Date:   Wed, 6 Apr 2022 22:44:13 +0000
Message-ID: <b140590dadea411ca3641b0537bfcd9f@intel.com>
References: <20220406063542.183946-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220406063542.183946-6-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20220406063542.183946-6-Smita.KoralahalliChannabasappa@amd.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+		/* Return early on an interrupt storm */
+		if (this_cpu_read(bank_storm[bank]))
+			return;

Is you reasoning for early return that you already have plenty of
logged errors from this bank, so OK to skip additional processing
of this one?

-Tony
