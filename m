Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E508124756
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2019 13:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfLRMzW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Dec 2019 07:55:22 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42622 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726799AbfLRMzV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Dec 2019 07:55:21 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBICjKrK028271;
        Wed, 18 Dec 2019 04:55:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=abAwylSmjSP3OzAgrsbXdXULV8U+YugVW5rm455Vl8E=;
 b=NVAefLkVEN6RB5KJ0VewkFL5O1NlhrQhB3+BvIv9vUWau1Qicf+0banipFaf3XBHCyAo
 COcjIcx/PRvQw2viZzUA29raK6P9Zl2SLuJijfZbAgSj+sedX77XXfhkhXTJPernSgBa
 p48WiJQ0lDQ+0Ohx4oq1wF1rJasPy3Hi4Y/zpOhelf/Y589nxv4AvLrNiFMX7gDe0WVU
 5x+WFKC6FaOM9o65Es+LNnEdx4KCGJuFjXecd4Bl/uefks2XGFGkOxkCbW0zi1vyt8tH
 5QEMhRidFjnIfQVHLXV6gHwECQL+azymTLk+fDsCSJAuha2wImGuXQvI6ELutnMRn7HH 1Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wxneaxjbf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 04:55:07 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 18 Dec
 2019 04:55:06 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 18 Dec 2019 04:55:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jytewqHNX337zBiUQl9pO+k99k7ztJMGCN5gG3+CsA8dVm3mUMUF/CsShpTTrbIBTVOYPVDmDLChyWkwJTundFtArf6u4xN//tZvCZFgArATF7vSMZIfeVdqgFlJOjZRSYhYDHhw4K2KSffoPwaliaOSyyiLagRdByvDaTRJYoQmGkgTbTVoZpxCz9188rCk+yayv9uqlW6Rtr5JkATmlJ5FdMR9tCaWoBTwHLsL8XCqd+XxYyaOEWowtQtjplZCK2ty62YCzHDbtsdOeLRoPfXIL28LV3nQrqNh7P2ISkTJGV6DQ9ZEDUGk4ywFp+NT0cBP7Y0iwXz939VLVJDRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abAwylSmjSP3OzAgrsbXdXULV8U+YugVW5rm455Vl8E=;
 b=R6Z6YqpQ4nHdcuN56QxV1ex99S647ej4hQZ76V/1OceUV/2BILx76qdGjifpOrDtE0M+cyOh6BNQ8dKbEQuSamW4SWfzxLHxKKV+/lyJhiJfVMfs3WXlOV04PsOTgFtgMUsVNOi4zEkpt4Q4h3NqJxjEEsTCGd6pbfzcS3Ut79wPKG7X9KyySSgIm9uphVudZdTDFYkyoE2nLsFtN8QQp8bc1BoZq7oYyDRlPjXuhFRzqItMLhEZLOU/5fQQdgws94OUgUjFPb6+ROwdBYbUjRoqh6tfCrS1G6onjzFI/xut37Btz0L3Buz/gZnLcWDK2iYD/OU/2StKP8aYVb0zsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abAwylSmjSP3OzAgrsbXdXULV8U+YugVW5rm455Vl8E=;
 b=RlbegeajPaEL8y/XNwIOTWlQuIgeSIF2G8TBPQGXIZfEfGY/zNyUN7hSQU7gj366vhKwq4EHUisxWk8q9RjPBcHMX2HBg7st7sIB7fp3Vr2qFop0jxCvLlPTCeEFesDM+dPo7SFvjz3JcwgRrDlgVb8pHPaggRS/GUaucWb2NbY=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3376.namprd18.prod.outlook.com (10.255.239.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 12:55:05 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 12:55:05 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0179.eurprd05.prod.outlook.com (2603:10a6:3:f8::27) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 18 Dec 2019 12:55:03 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     John Garry <john.garry@huawei.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Thread-Topic: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Thread-Index: AQHVtaJebbU/RvbI1kWoITeTj2bd/Q==
Date:   Wed, 18 Dec 2019 12:55:04 +0000
Message-ID: <20191218125456.kkqfuq7crshwwc7q@rric.localdomain>
References: <20191218062129.7400-1-rrichter@marvell.com>
 <0c7da2d7-1cab-f518-2309-f740d7ef36fa@huawei.com>
In-Reply-To: <0c7da2d7-1cab-f518-2309-f740d7ef36fa@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0179.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::27) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 222e3fd2-7d47-48e5-05ad-08d783b980be
x-ms-traffictypediagnostic: MN2PR18MB3376:
x-microsoft-antispam-prvs: <MN2PR18MB3376016E1F47B55A6C0810F9D9530@MN2PR18MB3376.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(478600001)(2906002)(86362001)(4326008)(71200400001)(956004)(53546011)(6506007)(16526019)(186003)(26005)(7696005)(52116002)(8676002)(64756008)(66556008)(9686003)(66446008)(66476007)(55016002)(4744005)(81156014)(81166006)(1076003)(8936002)(316002)(66946007)(54906003)(5660300002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3376;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DxWXUCyQ/NmUJhSrz8vSA/zJee9/GGotqiD2u4+D/U/XYVeASxllUqnTgAEDIsr4eZJ9WW5dyXdeEkOeee8P2TM/e+s9tU/nYzlPydYPU0AbXkDCv/S7MVzBCJSrRvXpvA8akc8x5KNs+FuxguEkZKVI9ccdwcrrZ6pknMmyRCqHY/P0yaaAu2sRTFGyZoLUdnowaR38dcdtqkmjU632wwao4tv3ftgfZ77YeClApCbiMjhMV+a+GNxYAcDoVBz2v8seAczTVuSvK9oMlJ7RIciYetUl4UEE57jBeN8NaYcPag9FiYtRuwso9jwbVu/YMmiTs+S+7etXmgIfaTftbuTRHFMgQahgQDdWM5b1SRDLvuI4EQ7p54LXEIMLac/NhH+n6z5L0X5xxa8O5wUPFR0gOLLrOqYestoGGbh1qFGBBceJwSYteLgqStHVmSan
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DE9F1EE80845F4EB1FE9F76FB9B3F47@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 222e3fd2-7d47-48e5-05ad-08d783b980be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 12:55:05.0198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odDx0TB5rFZmIkZEv8ZRtRs9ZpHuUBMY+TcP1FryRgI9cNaKcZnwXeD10s6PKy6mSGeHXxxwSmNEI2OGthFWhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3376
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_03:2019-12-17,2019-12-18 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 18.12.19 11:28:25, John Garry wrote:
> On 18/12/2019 06:22, Robert Richter wrote:

> > The patch has been tested with the above kernel options, no issues
> > seen any longer.
> >=20
> > This patch should be marked as stable.
>=20
> Not sure why you haven't...

I leave that to the maintainer as he is editing the SOB chain anyway.
The patch would be sent to the stable list already which may cause
confusion.

>=20
> >=20
> > Reported-by: John Garry <john.garry@huawei.com>
>=20
> The splats and leaks have disappeared for when booting my arm64 machine:
> Tested-by: John Garry <john.garry@huawei.com>

Thanks for testing.

-Robert
