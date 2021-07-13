Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9AE3C734A
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jul 2021 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhGMPdb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 13 Jul 2021 11:33:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:51843 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236992AbhGMPda (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 13 Jul 2021 11:33:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="274015979"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="274015979"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 08:27:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="503184746"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jul 2021 08:27:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 13 Jul 2021 08:27:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 13 Jul 2021 08:27:01 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Tue, 13 Jul 2021 08:27:01 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
CC:     "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] EDAC/amd64: Use DEVICE_ATTR helper macros
Thread-Topic: [PATCH v3] EDAC/amd64: Use DEVICE_ATTR helper macros
Thread-Index: AQHXd7OeuAHraXCsaUyi/VM2AGH0MqtBByhQ
Date:   Tue, 13 Jul 2021 15:27:01 +0000
Message-ID: <43f0eb92643a4613992714effefed757@intel.com>
References: <20210713065130.2151-1-dwaipayanray1@gmail.com>
In-Reply-To: <20210713065130.2151-1-dwaipayanray1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Instead of "open coding" DEVICE_ATTR, use the corresponding
> helper macros DEVICE_ATTR_{RW,RO,WO} in amd64_edac.c
>
> Some function names needed to be changed to match the device
> conventions <foo>_show and <foo>_store, but the functionality
> itself is unchanged.
>
> The devices using EDAC_DCT_ATTR_SHOW() are left unchanged.
>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Yazen,

Boris is on vacation. Should I queue this change?

-Tony
