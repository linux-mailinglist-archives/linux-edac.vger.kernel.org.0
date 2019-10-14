Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F80D61E3
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 14:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfJNMAl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 08:00:41 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:15834 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730300AbfJNMAk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 08:00:40 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9EC09Tc028549;
        Mon, 14 Oct 2019 05:00:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=4uTeaOpZDpXUzWN59NysHT46Gbs0pC0TCYAC2MfYJWc=;
 b=sbJC5JJIuk0L6usYfEfEg+vO9EM1VCQEug8sRv2UbLbf+BUmtXoBMqQ/jDbo3IAROqKL
 9J+9fm2CldaPgrfyb1uvDeuoGzLZecNXs2a3FZGcn2ZRQZ/81Yg4J8XdZ5v+HMNuXYFN
 I7yRt6Cq+ki+m7+TN1f5DYAEG1n0YNYWrMqRioMfNm4WbtNddjNNWijSHm8G9sNy/1WO
 Of5AqJAZT2TI6/OAEVitdgow7QdHy2S3nlYH2RRYeMmwSlYX8Cgx56DMnK2r4Z68UO5N
 pW4u39y4AULHZw843UmiHGJmmi/gNVVBMobfj+3W58CbIvXL1ecVeA7gRY+/6b2Djob6 /Q== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vkc6r6anp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 05:00:32 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 14 Oct
 2019 05:00:32 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 14 Oct 2019 05:00:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqAzlmSrejqqvEhSDw87+aS4phM+JI/8qFphzke3XuGVyH+wk1RLR4KEB5cWSoE3KUTx5/oz1GqT4pMsLYYjew+/wPTdChcHXf3Ab5fekSEYyh/u/VFkCPXpLck48b7G5E9B8H5Zl4+aTA4a6zRDcMN8ipH/j7iivnQOy1PXuHL2VhXR3nyqf7+XFJLi0PS233UkjI2Lm4ySn7CxS4UfNXumv2G60D43qld3rVAUAUTz5SXfmj2peEpTde5bJ51El4QTzxjKzczyXji2HmW4XoYW1ps8J6kfQLAT4Ybdx3dhQs+xFZc1kP3RQuAjEToMJbXbqQAxbgVXGOXYCCTkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uTeaOpZDpXUzWN59NysHT46Gbs0pC0TCYAC2MfYJWc=;
 b=nz8HjEROMgcjdApc0MYoRen+y5Fn5Kzmvcd2BkRMJ+1+lJE7Q7sa/6SkVfXCMIL3j0WbIFGSP5KyGkmTvBY5QP0gsct+k6wVVhty1X7HypAC9trG/vmFobmjtUYPSIegczq+h9JQpWziCy08yy7Eyx7S4NC1xJ4CVidQEpDcHq1shG0p6s9oJsKu5XSy90Y7VYHsmdpdEThOH6iK23nhA7anLf8M1A74MaPV1WsUJ4StDm7FjMi3dKOE7bug9kkyBpPFZO2DZf6w1OQVMe/3p30S5hu13GBzmiWIA2Axf8LhkrEYHR8GTJirRkx0G17tqOaafav7V1J4ExtjMb/RZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uTeaOpZDpXUzWN59NysHT46Gbs0pC0TCYAC2MfYJWc=;
 b=qVjU/MQT4gmsos7EtRDj8chFJT+BCqDRjGqABt8GDmlNhpCkl/cifo5Qk0qt4MVl9K7Z+qA8dh+sGUdQt1GSWRl/Fdau9Yh7wMr/tCloE4ecHuM+UEGf+I7UTwpuNkjxhRI5CiltMsVsyuagNyKyhZbXYPyKp3hkG3K4r9jQ8Yg=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2941.namprd18.prod.outlook.com (20.179.22.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 14 Oct 2019 12:00:30 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2347.023; Mon, 14 Oct 2019
 12:00:30 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/19] EDAC: Rework edac_mc and ghes drivers
Thread-Topic: [PATCH 00/19] EDAC: Rework edac_mc and ghes drivers
Thread-Index: AQHVf6jLshPLJWnlTE6zMo1DcW8g6KdaDpmA
Date:   Mon, 14 Oct 2019 12:00:30 +0000
Message-ID: <20191014120023.jsrwq4ptxuvuw2pq@rric.localdomain>
References: <20191010202418.25098-1-rrichter@marvell.com>
In-Reply-To: <20191010202418.25098-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0255.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::31) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28f94daa-b533-4c30-7c36-08d7509e1c30
x-ms-traffictypediagnostic: MN2PR18MB2941:
x-microsoft-antispam-prvs: <MN2PR18MB294123A4C9C8EDB9061AD9D6D9900@MN2PR18MB2941.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39850400004)(366004)(376002)(136003)(189003)(199004)(11346002)(446003)(26005)(102836004)(53546011)(256004)(386003)(6506007)(66946007)(186003)(66476007)(66556008)(64756008)(66446008)(14454004)(71200400001)(71190400001)(478600001)(66066001)(476003)(486006)(25786009)(2906002)(5660300002)(6916009)(4326008)(86362001)(1076003)(6436002)(229853002)(6486002)(6246003)(6512007)(9686003)(54906003)(8676002)(316002)(76176011)(4744005)(7736002)(8936002)(52116002)(99286004)(6116002)(81166006)(3846002)(81156014)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2941;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bcsVuzaHgO5G5VPKeH4FnK+3NJju56D5U/W0vBPraSK9jYM3l7qE3xydhYmwCDZfcKd53rBy5UWyGVUee8R8b558cvpQD6d2x35pwEAeP8aUSE3Yuk+nsjYInC3aTZSv3w2OS1xNkUPRUZZYss2w6heMwuHGap0oGqRxcfx8Fkyu/P3GE07kPtFLz9sZA26atdvOOxC+dWQk1ibmXfpJO3QF4M370tWCYygUb7x+Vdidl/zlKAT6qd5RXUGPIvnzHpyvbaipjkLU9sW8cGJda3ekbro/gAuIIVHVJfcsONQipPgs9PdiwX5duoQxJ5A5hRSOr8h2HwJhg+0REDHcEccg9X9sxMvQjKJnfS+FYMGNOosJg3hsbU3Yld3eEHNqaDoCewzalDKpNlC7xIEGomXgT7BrPAv4ImQaOL86OoU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <576043D66995224296DE2E659C87CCB7@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f94daa-b533-4c30-7c36-08d7509e1c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 12:00:30.6027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjncbrLEw6U74d+18+t1t9ZL7lApAeu3Cb28PDfHaljtDybDw2MpyXwhFvOYnOpMiIi4TcRwBkt+Qu7des2DsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2941
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_07:2019-10-11,2019-10-14 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10.10.19 20:25:01, Robert Richter wrote:
> This patch set is a rework of the ghes_edac and edac_mc driver. It
> addresses issues found during code review and while working with the
> code. The changes include:

Thanks Mauro for your review of the whole series. I hope I could all
your concerns address with my answers.

-Robert
