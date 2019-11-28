Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD4110CF74
	for <lists+linux-edac@lfdr.de>; Thu, 28 Nov 2019 22:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfK1VNI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Nov 2019 16:13:08 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56366 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbfK1VNI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Nov 2019 16:13:08 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASLC57s031971;
        Thu, 28 Nov 2019 13:12:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=t+0OBp2XWHrGQ8gn0kkmxyU78ES0E7ixLfIHil+Gs0Y=;
 b=uVsdix33q7KtngB+5C1zUoSCFuJXK8L2ZRnip+cLH4CyeZU6xPA0M195Ag/WIQV4yTAK
 XPdRg5wktZVGeuapmX35IgLJDJGP1IY+uAVSQMU9g0fBvIBvXFeovkmFkgFMYZ7GwcqV
 t1gVUrM2fJWeHrRfFVTGPr3sgHdmb3kgMsJzNK1ChIKDvMexwrrWNjuVSiC0DbwgxH9i
 EHHT4HAu4GpBjucQQOOjHQ8A5nbRU08ajCHxMaxZcUpqd5bL71AZqU+oQaNglRdGVWhV
 so153G8oQSQmdC3NyJm2/IMRc6Yvq6pxa7g7WDs4lyOhEk7f2woJDBWxigfp0O2xexQq 8w== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2whmdyf1t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 13:12:49 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 28 Nov
 2019 13:12:49 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.58) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 28 Nov 2019 13:12:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0N19kFdS/ZKY6HQItHzRg6igQQTp82JrIgbDDqSK++MASv07f90xfQsKfYXfsZa5PnP6wm3oGxLMYMsbNM6NYTk05KNqwpg1zEV913Q0cqZ4ZsWTLGnxcHVZP5/jonUJeceMaye64mgJKr/2Gi2e7qiwQeUVzZEqc0ha1WFxdtIyP7k+94HVo6ERGSkQGVjQopj8QFuTQrEmrgnIx915ily+sc5pwwPsWjBHp/UdDt/ANPbO95g7U0ZTsMax5g1fg3b/Z7CQKBfRwcROeMW/f1Cy5c3XRaqbn/cMPADhOhJ00RtRSAbxhaydG/W2J8t0TQZAgGve+bZyRVlgsk8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+0OBp2XWHrGQ8gn0kkmxyU78ES0E7ixLfIHil+Gs0Y=;
 b=IbGB+u0U21hMX6eyHrHirm5E5FWgcG71TDjbI8mGp3bpS4q2ZPaYeRoeHph605CEDP9XQXiasnWyavAp2JPTEoh6tSznJx5n9URG7ruoEu9QAM7Tk68qY92ui007IOo6usNF7XE7cDgw+dmbXAX1eV7g1wyrmn8E6ZBbpK8MGOJ63C2WNgEjHM51pIyWxah3hxFLc4Wfw7kbGajWGdzKam4a13idtDNbWSr1i1iqj7FnxZQoUJKaOK9l1/ZoiaqAthkpz6JjL5mR312ujCnnFXdQ2wM1MX4O5geFq8kpYlU0iFrx0/VuUzevxyBX7aMa9GYsDX9brQyz5oLA0fXK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+0OBp2XWHrGQ8gn0kkmxyU78ES0E7ixLfIHil+Gs0Y=;
 b=a4sIscIpEj3UIqMyR4CAJIxRdY2/U9ywzoyXdKCg6Hilun4lrCJMJamFgAfG9Bk8ghiSsUwmhEiXCTnsoQ9MhBOYd+1VNR9whGE90V9mao0GWTSm7tQkP8X/nmhMV6pGyhI5bJtA4SGqI8yHbenrZrU9altsDUEr06K3se8tuRo=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2703.namprd18.prod.outlook.com (20.179.21.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 28 Nov 2019 21:12:47 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 21:12:47 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     John Garry <john.garry@huawei.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Huangming (Mark)" <huangming23@huawei.com>
Subject: Re: linuxnext-2019127 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Thread-Topic: linuxnext-2019127 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Thread-Index: AQHVpjCV6GSWIvfCp0Kx4OaQQLCBrA==
Date:   Thu, 28 Nov 2019 21:12:47 +0000
Message-ID: <20191128211240.yuuhf4xkzhl2jvfw@rric.localdomain>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
 <93bdc04e-9e8f-b766-6e97-9fd9e1460a8c@huawei.com>
 <20191121142302.rhvgkgqpiubidhtu@rric.localdomain>
 <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
 <20191122112842.tmf4lkj52hpv6tqd@rric.localdomain>
 <4c1bd075-75ec-8445-9595-467b88a406b3@huawei.com>
 <957a809b-9efd-0979-df5d-a4f095da6147@huawei.com>
In-Reply-To: <957a809b-9efd-0979-df5d-a4f095da6147@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::30) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99efcbfa-1d94-4267-8b84-08d77447b7c3
x-ms-traffictypediagnostic: MN2PR18MB2703:
x-microsoft-antispam-prvs: <MN2PR18MB270340BA5BE997C95B844FB8D9470@MN2PR18MB2703.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(189003)(26005)(3846002)(6486002)(6436002)(1076003)(54906003)(66446008)(186003)(2906002)(229853002)(66556008)(6916009)(71200400001)(478600001)(71190400001)(5660300002)(6116002)(66476007)(7416002)(256004)(64756008)(6246003)(6512007)(9686003)(446003)(66946007)(66066001)(4744005)(11346002)(8936002)(52116002)(316002)(4326008)(386003)(7736002)(14454004)(305945005)(53546011)(6506007)(86362001)(76176011)(8676002)(99286004)(81156014)(102836004)(25786009)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2703;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ff6YYLsgFfgtt6odmBKOr6hzy3tQNrZvXVD5nPPlH4VRN+sSpAdLgK4LJAoAiOoFtou/A3igAFAxv14w2jCQJBfc65IGHC5SLxlz47LP5zNaIDH0KL1BKKd9rT9Z5h3Sl7YzyJDzvxm3zm5ZWYYGqYh3DHiKJbE3+qlzyunxuwwInvVRqmfQiTQJk+z/M5mt6yH/sYe6NC4uIq5lVh4UsWNK6k0apSrIpeUjF18le+U/MBEYpxTuRoYz623UnEyTpPgLmvQnf2L4saJcmZwwdBe0WuJlPDeV8CswWA3zQ9TSbGR44fBU6oOEZpLuDebGcPXR9uglR6/wf2FXVOkKfu57P34NLHPWcOETE8trPiQYWPFA/85kG2UgvttmBn8uCDEplgdOYrQogD4SOby6cg5zkZM8JykSlPc+BdDsUrPQAIKr2v1ilfZFK38JOniH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24B035636B66B240B072A9B672953A58@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 99efcbfa-1d94-4267-8b84-08d77447b7c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 21:12:47.2769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: om5EcBalcaOFJlt4+JR++ARkT9uooNX9DkGBBIBuQWgzOYTrlaipRUqny+fIPKQcaCThYnlzjVHXWEOqBauR6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2703
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_07:2019-11-28,2019-11-28 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 27.11.19 17:07:33, John Garry wrote:
> [   22.104498] BUG: KASAN: use-after-free in
> edac_remove_sysfs_mci_device+0x148/0x180

It is triggered in edac_remove_sysfs_mci_device().

device_unregister(&dimm->dev) not only removes the sysfs entry, it
also frees the dimm struct in dimm_attr_release(). When incrementing
the loop in mci_for_each_dimm(), the dimm struct is accessed again
which causes the use-after-free. But, the dimm struct shouln'd be
released here already.

edac_remove_sysfs_mci_device() should not release the devices at this
point. We need clean release functions for mci and dimm_info and
refcounts to protect pdev/dev mappings. And mci_for_each_dimm() must
be checked how it handles device removals and if it is safe.

Let's see how this can be fixed.

Thanks for reporting the issue.

-Robert
