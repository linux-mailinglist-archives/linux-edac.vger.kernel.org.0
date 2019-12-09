Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B2E1178E0
	for <lists+linux-edac@lfdr.de>; Mon,  9 Dec 2019 22:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLIVxB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 9 Dec 2019 16:53:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:4358 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIVxB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Dec 2019 16:53:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 13:53:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="244612438"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2019 13:53:00 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.121]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.82]) with mapi id 14.03.0439.000;
 Mon, 9 Dec 2019 13:53:00 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Thread-Topic: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Thread-Index: AQHVqukc0nBJ+8kmJ0Gr0NWk7vbFu6eyX2aQ
Date:   Mon, 9 Dec 2019 21:52:59 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
In-Reply-To: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjA3ZDY1OTUtNDdiMy00NjMzLWI0MzAtMmU4YzBmMzgxZDA0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUXI5MEtcL3dNQjNtTTlwMnZSdGlETnZybW5EU216QTlVdVdyajRJY0c3ZzNHdHREUzdzZEtVTFNveEFLcU9iaWIifQ==
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

>	EDAC skx: Can't get tolm/tohm
>
> for each CPU core, which is noisy. This patch makes it a debug message.

This looks like we call skx_init() once per core. Do we keep calling it because
the calls are failing?  Or do we do that even when calls succeed?

I was only really expecting that skx_init() would be called once.

-Tony
