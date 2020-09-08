Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19229262266
	for <lists+linux-edac@lfdr.de>; Wed,  9 Sep 2020 00:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIHWIh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 8 Sep 2020 18:08:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:56112 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgIHWIg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Sep 2020 18:08:36 -0400
IronPort-SDR: 7cn6yonKJx9eGFYWYrpRUlas6gfSx/Kz5qKUC90bncyqxqVvJobyXoc8FeMHT9Q+naZOTcEShp
 8aduVjc+sCdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="222438979"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="222438979"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 15:08:35 -0700
IronPort-SDR: iD9INV+cK10hvjNf5wcoCWfECqjkvPJqs+NlqjOxlQIBOkqvk9Fz6c3A70SJlr4O8fPg3Hqkn0
 ARgq+EuH9Tew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="317340286"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 08 Sep 2020 15:08:34 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Sep 2020 15:08:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Sep 2020 06:08:30 +0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Tue, 8 Sep 2020 15:08:28 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "trix@redhat.com" <trix@redhat.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] EDAC: sb_edac: simplify switch statement
Thread-Topic: [PATCH] EDAC: sb_edac: simplify switch statement
Thread-Index: AQHWhSwd2aPyoNmgw0mlzN1Re9AsfalfTkog
Date:   Tue, 8 Sep 2020 22:08:28 +0000
Message-ID: <7525690b6aaa4e539989b9c2e5703a56@intel.com>
References: <20200907153225.7294-1-trix@redhat.com>
In-Reply-To: <20200907153225.7294-1-trix@redhat.com>
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
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> However by initializing the type to DEV_UNKNOWN the 3 case can be
> removed from the switch, saving a comparison and jump.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied. Thanks.

-Tony

[Boris: Pushed to edac-misc and edac-for-next branches in RAS tree]
