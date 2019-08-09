Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47963872AB
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2019 09:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405415AbfHIHHh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Fri, 9 Aug 2019 03:07:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:17415 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfHIHHg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 9 Aug 2019 03:07:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 00:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="177556393"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2019 00:07:35 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 9 Aug 2019 00:07:35 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 9 Aug 2019 00:07:35 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.80]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.65]) with mapi id 14.03.0439.000;
 Fri, 9 Aug 2019 15:07:33 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Stephen Douthit <stephend@silicom-usa.com>,
        "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg() from 64K
 -> 32K
Thread-Topic: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg() from
 64K -> 32K
Thread-Index: AQHVTiskHjYyDh8ZF0eccCUFKX9IfabyZK+w
Date:   Fri, 9 Aug 2019 07:07:32 +0000
Message-ID: <E6AF1AFDEA62A94A97508F458CBDD47F7A264595@SHSMSX101.ccr.corp.intel.com>
References: <20190808205147.25547-1-stephend@silicom-usa.com>
In-Reply-To: <20190808205147.25547-1-stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTFiOWNmMWQtNmFiNS00NGMwLTg2N2QtZTIzOTc4YmYyOTAzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTHNCVmV3QTloY240R3JTNUV1YUl4S0xNU3NoQ25EVko5VlpHdXNRZDBGdWszclhud0JwMlpOSWhscENjMTBhMSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> 
> BIOS has marked the 32K MCHBAR window as reserved, so when dnv_rd_reg()
> tries to ioremap() a 64KB region you get warnings like:
> 
> resource sanity check: requesting [mem 0xfed10000-0xfed1ffff], which spans
> more than reserved [mem 0xfed10000-0xfed17fff] caller
> dnv_rd_reg+0xc8/0x240 [pnd2_edac] mapping multiple BARs
> 
> ioremap() the correct size on Denverton platforms to get rid of those warnings.

I've several dmesg logs for loading the pnd2_edac driver on a Denverton server successfully. But the logs haven't got such warning.

-Qiuxu 
