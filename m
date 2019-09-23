Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF10DBBF04
	for <lists+linux-edac@lfdr.de>; Tue, 24 Sep 2019 01:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbfIWXg7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 23 Sep 2019 19:36:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:61738 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfIWXg6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Sep 2019 19:36:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 16:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; 
   d="scan'208";a="272450283"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga001.jf.intel.com with ESMTP; 23 Sep 2019 16:36:58 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Sep 2019 16:36:57 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.199]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.194]) with mapi id 14.03.0439.000;
 Mon, 23 Sep 2019 16:36:57 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH 1/2] EDAC, skx_common: Refactor so that we initialize
 "dev" in result of adxl decode.
Thread-Topic: [PATCH 1/2] EDAC, skx_common: Refactor so that we initialize
 "dev" in result of adxl decode.
Thread-Index: AQHVaoCM0E6JatW30EOzRWBnyLyDk6cxu14AgAg8+JA=
Date:   Mon, 23 Sep 2019 23:36:57 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F478D2A@ORSMSX115.amr.corp.intel.com>
References: <20190913221344.13055-1-tony.luck@intel.com>
        <20190913221344.13055-2-tony.luck@intel.com>
 <20190918074040.3e76a2ac@coco.lan>
In-Reply-To: <20190918074040.3e76a2ac@coco.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzBlYmRjZDAtYTdhZC00M2Y1LTg3NjgtYTM3NzQzMjYxMGFhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia0RQSWZLRFBRdDJYSUtyUUpVb0srZmN2KytpblhNZEtNWENnbXlReVh3Um43RUtyd3dCU0dcLzJlUWpGc2F0WWsifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>> +	if (res->imc > NUM_IMC - 1) {
>> +		skx_printk(KERN_ERR, "Bad imc %d\n", res->imc);
>
> I would report this via EDAC as well.

It would be nice, but I don't see how.  This function is trying to figure
out which memory controller (and thus which EDAC struct mem_ctl_info)
is connected to this error.  If it fails, then we don't know where to report it.

On the plus side this error (and the other one you flagged) "can't happen"(TM)
so we shouldn't expend too much effort to solve this.  Code must give up here
rather than trigger out of bounds array accesses later.

If we did want to solve this, we could invent a mechanism for EDAC
drivers to log errors not related to a particular memory controller
(by passing NULL to edac_mc_handle_error()???).

-Tony
