Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB2CC117C04
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 01:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfLJAC5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 9 Dec 2019 19:02:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:40614 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfLJAC5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Dec 2019 19:02:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 16:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; 
   d="scan'208";a="207080654"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga008.jf.intel.com with ESMTP; 09 Dec 2019 16:02:46 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Dec 2019 16:02:46 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.121]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.200]) with mapi id 14.03.0439.000;
 Mon, 9 Dec 2019 16:02:45 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     'Aristeu Rozanski' <aris@redhat.com>,
        "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>
CC:     'Borislav Petkov' <bp@alien8.de>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: RE: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Thread-Topic: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Thread-Index: AQHVqukc0nBJ+8kmJ0Gr0NWk7vbFu6eyX2aQgAAkOBA=
Date:   Tue, 10 Dec 2019 00:02:45 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
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

> This looks like we call skx_init() once per core. Do we keep calling it because
> the calls are failing?  Or do we do that even when calls succeed?
>
> I was only really expecting that skx_init() would be called once.

So (by experimentation) it seems that if the module load fails it
will be retried num_online_cpus times (though not bound to each
CPU in turn ... it will maybe try the init call on the same CPU multiple
times, but miss running on some CPUs).

If the load succeeds, then whoever is repeating the load decides
to stop.

-Tony
