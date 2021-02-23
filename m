Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E42323172
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 20:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhBWTdV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 23 Feb 2021 14:33:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:39422 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233954AbhBWTdU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 23 Feb 2021 14:33:20 -0500
IronPort-SDR: t5mlXov26QGofHhbi5dW6U1a9S2Vt04xZTyDRggvFabOCJQROJIKrj39oQgZwOv/7gcPyuQJq1
 vzVFfWgXHdXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="185039188"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="185039188"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:32:38 -0800
IronPort-SDR: jiCJmiMzgVQD1IYy3BRdRasT6qcgZeE0faiDmCw/LtvasEeAVmOqewZgXn4jKyvouLxF3LUQAB
 yJwGBvq1RQoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="431065712"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2021 11:32:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 11:32:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 11:32:37 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Tue, 23 Feb 2021 11:32:37 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: RE: [PATCH v2] Dump cper error table in mce_panic
Thread-Topic: [PATCH v2] Dump cper error table in mce_panic
Thread-Index: AQHW9W1UcvZJLq301kWjYofz6/0Q7Ko9Rv/QgCjd3ICAACSCsA==
Date:   Tue, 23 Feb 2021 19:32:37 +0000
Message-ID: <434eba7a568a4b9f8eb7ee11a5c8b04f@intel.com>
References: <20201104065057.40442-1-yaoaili126@163.com>
        <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
        <20201118124538.GI7472@zn.tnic>
        <20201119134057.37ca2c19.yaoaili@kingsoft.com>
        <20201119174508.GE3769@zn.tnic>
        <20201120172235.620eb826.yaoaili@kingsoft.com>  <20201120102422.GA712@zn.tnic>
        <20210128200128.6f022993.yaoaili@kingsoft.com>
        <e9645a3ff93e46d4aabdf7dd45bfc4d7@intel.com>
 <20210223171809.7df62b08@alex-virtual-machine>
In-Reply-To: <20210223171809.7df62b08@alex-virtual-machine>
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

> I am not smart enough to get the point. I have paid a lot of time for this patch, 
> I need an result even it doesn't work. so i like the reply like this:
>
> 1. this patch is meaningless, and should be rejected.   
> 2. this issue is real, but we need other methond, not this patch.
> 3. the patch need to improve.

I don't want to say that the patch is meaningless ... it may be useful to you
in your environment to help sort out machine checks due to h/w issues vs.
programming errors in the machine check recovery code.

But I don't think it is generally useful in the upstream code.

-Tony
