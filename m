Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA102546C0
	for <lists+linux-edac@lfdr.de>; Thu, 27 Aug 2020 16:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgH0OZq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 27 Aug 2020 10:25:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727933AbgH0OYI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Aug 2020 10:24:08 -0400
Received: from lhreml716-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 218CF1DAA701CF95398F;
        Thu, 27 Aug 2020 15:06:46 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 27 Aug 2020 15:06:45 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Thu, 27 Aug 2020 15:06:45 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Shiju Jose <shiju.jose@huawei.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>
CC:     Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V2 topic-edac-5.1 0/2] EDAC: Add support for reporting the
 non-standard errors to vendor drivers
Thread-Topic: [PATCH V2 topic-edac-5.1 0/2] EDAC: Add support for reporting
 the non-standard errors to vendor drivers
Thread-Index: AQHWfHsztKgkgsUqmkSak6t0xgfOW6lL/KMA
Date:   Thu, 27 Aug 2020 14:06:45 +0000
Message-ID: <66db47a16b454d899908bb8f5cfa811b@huawei.com>
References: <20200827140128.1113-1-shiju.jose@huawei.com>
In-Reply-To: <20200827140128.1113-1-shiju.jose@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.87.119]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Sorry. Please ignore this.

>-----Original Message-----
>From: linux-edac-owner@vger.kernel.org [mailto:linux-edac-
>owner@vger.kernel.org] On Behalf Of Shiju Jose
>Sent: 27 August 2020 15:01
>To: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; bp@alien8.de;
>mchehab@kernel.org; tony.luck@intel.com; james.morse@arm.com;
>rrichter@marvell.com
>Cc: Linuxarm <linuxarm@huawei.com>
>Subject: [PATCH V2 topic-edac-5.1 0/2] EDAC: Add support for reporting the
>non-standard errors to vendor drivers
>
>Presently non-standard HW errors are not reported to the vendor drivers for
>the recovery.
>This patch set adds support for reporting the non-standard errors to the
>registered vendor drivers.
>Also adds HIP08 EDAC driver, for the  recovery of the PCIe OEM errors on
>HiSilicon HIP08.
>
>RFC -> V2
>1.Add error recovery for the PCIe local errors 2.Removed code for the other
>OEM errors from HIP08 edac driver
>  because there is no current requirement for the recovery.
>
>Shiju Jose (2):
>  EDAC: Add support for reporting the non-standard errors to the vendor
>    drivers
>  EDAC: Add handling for the PCIe OEM errors on HiSilicon HIP08
>
> drivers/acpi/apei/ghes.c                    |   5 +
> drivers/edac/Makefile                       |   3 +-
> drivers/edac/edac_non_standard.c            | 124 ++++++++++++++
> drivers/edac/hisi_hip08_edac_non_standard.c | 255
>++++++++++++++++++++++++++++
> include/linux/edac_non_standard.h           |  74 ++++++++
> 5 files changed, 460 insertions(+), 1 deletion(-)  create mode 100644
>drivers/edac/edac_non_standard.c  create mode 100644
>drivers/edac/hisi_hip08_edac_non_standard.c
> create mode 100644 include/linux/edac_non_standard.h
>
>--
>1.9.1
>

