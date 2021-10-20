Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D933434E9C
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhJTPJO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 20 Oct 2021 11:09:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:51232 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTPJO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 20 Oct 2021 11:09:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="208902821"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="208902821"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 08:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="551674637"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2021 08:06:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 08:06:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 08:06:58 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Wed, 20 Oct 2021 08:06:58 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>
Subject: RE: [PATCH v2 2/5] x86/mce/inject: Warn the user on a not set valid
 bit in MCA_STATUS
Thread-Topic: [PATCH v2 2/5] x86/mce/inject: Warn the user on a not set valid
 bit in MCA_STATUS
Thread-Index: AQHXxUI8p9AjIXdBe0GwapWxUk7Kj6vb/UKQ
Date:   Wed, 20 Oct 2021 15:06:58 +0000
Message-ID: <cd4be28ced3544f5b0eae397ccbe83c0@intel.com>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-3-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20211019233641.140275-3-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+	if (!(i_mce.status & MCI_STATUS_VAL))
+		pr_warn("Handlers might ignore signatures with Val=0 in MCA_STATUS\n");

I don't think there is any "might" about this. All code paths start by checking for MCI_STATUS_VAL
and skipping if it isn't set.

s/might/will/

-Tony
