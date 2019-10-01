Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7ACC31D2
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2019 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfJAKyB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Oct 2019 06:54:01 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:58688 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbfJAKyB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Oct 2019 06:54:01 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91AjS8h026757;
        Tue, 1 Oct 2019 03:53:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=+4+40uN+ujtsB26+w80tVd/FyNqFoK+C+410NcR9SQg=;
 b=WDVVgRNdt7j/KSMYWNCJIBgqRMk1iMsGc6o6d8BzutKoxo6ahjYs8a7X9wg7SuGfebqh
 spUbAbkItS8fDxOIr/JicZCMRwDVZWLeCLQUj9tfY2w7zkiMgFhvbQb/0SpRfLB1xuCw
 AljhCPWBHwg9ZjMsxKc7LX09l5Mgwx0PRlKdohMWv/GCwkmtV6vCNF+1c/k9NqWafmAc
 nVmRC5nl/7vTYiFxFrTLuuT22JG+6HWfD9g4IWFbWK9TjlwsdHKVHnt5z4cH36P2nhdL
 9WaJvS4QTdzMnJjqLyIrChM/mDabeuINRNHiY9BBuB72CWBcWFG/2KZngGkWTpsXyd+C BA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vbur19rjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 03:53:50 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 1 Oct
 2019 03:53:49 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.56) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 1 Oct 2019 03:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCFeNMx9UBTx48pH2p2IAKDvOxSzzIW8azvWHn9b7TPtEVS/pssc7msaJNF07sOTuXH7XSM9Bkfa0TZLlDspZTc54Pfl2FSzErJQC/1/XbYl7fZHq/rhj0oV09JkmOxQ+JXuusyJcwMRuWV0SUnxMI76kC+CpQ/lqrdlJchd87I7ZeOHEf4/0TOAdwBiqWbChK9mEOFB5146BUPUWreLIoArGHSV6aopCfeG6ElI0fprvEZC12NZgUsWVjH4O9jO2egqXRF0hfHUToJcTKWxxx8apo09S4AYCpl6+8F9BVxvaA5/OBZNvGSOzYq2uByujydsbP0UDyQA2qNC93VluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4+40uN+ujtsB26+w80tVd/FyNqFoK+C+410NcR9SQg=;
 b=fXotHN1c07Vw4cg74LqQ0JtGHJDvxrJxZ2fY0GufOtoXa09jEYPVTgEVmZJtur4s9ahrCMChqCVKXVxsAVgUr/lrQJkMx9Rhm3vFQV6HzE9msyPh4TRkN7NVaUIyIYHDPefgMjqVWMOMLzNZh27O2HgRcNZ1frL8Y1C6FonaPCUChK9iEkNMmRgUahzwECXtOcxHD6k5xSv4XU5JORcFUKabw4JNlY0op7sccN7hVH6YcpgehH9CazuGIyReU4MayabESIS8TD3VAoczxiLjsP0emJAN1KHxVDQfOCqVwVFJY7aUgBTW7dAG+0Vi9asgSgLFVdPU6eYhRCLXmh5mvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4+40uN+ujtsB26+w80tVd/FyNqFoK+C+410NcR9SQg=;
 b=jFLGmpJRctfhvtcmcKp+sWozKZO/kBHOwUfGHP7UPvxL2FYYOwOMBaMHb1He+5oZUjoMetsw5D7h2paC6q+rykE8ywKVRTMIMuGBbnsOSXccWnHeCOfNPs9MOCq31nyV1AWKuK6M5E2R57Yq0nSkv8bDekZ6xrQaThl6x8d+2ss=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3261.namprd18.prod.outlook.com (10.255.237.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 10:53:48 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::88e4:c340:f520:6b36]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::88e4:c340:f520:6b36%3]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 10:53:48 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Hanna Hawa <hhhawa@amazon.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
Subject: Re: [PATCH v4 1/2] edac: Add an API for edac device to report for
 multiple errors
Thread-Topic: [PATCH v4 1/2] edac: Add an API for edac device to report for
 multiple errors
Thread-Index: AQHVeEaAgxYDdzoLUUm+D1Y78e5zpw==
Date:   Tue, 1 Oct 2019 10:53:47 +0000
Message-ID: <20191001105339.5tbdw2mrb2uwit6j@rric.localdomain>
References: <20190923191741.29322-1-hhhawa@amazon.com>
 <20190923191741.29322-2-hhhawa@amazon.com> <20190930145046.GH29694@zn.tnic>
 <20191001065649.a6454bh4ncgdpigf@rric.localdomain>
 <20191001083242.GA5390@zn.tnic>
 <20191001094659.5of5ul2tof6s75px@rric.localdomain>
 <20191001102539.GB5390@zn.tnic>
In-Reply-To: <20191001102539.GB5390@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0321.eurprd05.prod.outlook.com
 (2603:10a6:7:92::16) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7af98009-8590-4736-9068-08d7465da2f1
x-ms-traffictypediagnostic: MN2PR18MB3261:
x-microsoft-antispam-prvs: <MN2PR18MB32618F80BEDEB6900E57939AD99D0@MN2PR18MB3261.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(189003)(199004)(186003)(76176011)(229853002)(6486002)(386003)(52116002)(66476007)(2906002)(102836004)(64756008)(66066001)(66556008)(66446008)(66946007)(6512007)(99286004)(26005)(478600001)(9686003)(53546011)(54906003)(25786009)(14454004)(6246003)(316002)(6506007)(3846002)(6116002)(6436002)(4326008)(256004)(7416002)(8936002)(86362001)(305945005)(486006)(6916009)(5660300002)(7736002)(8676002)(446003)(71190400001)(81166006)(71200400001)(11346002)(1076003)(476003)(4744005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3261;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kk0MqzBpDenGoQ5gHMDgyv13LSILSIik9cu6ThggC4O4Vgz9ZuWw9Zv9VNl5DIv/gK4Nx/sIm2rmxelQaaNSPQNs/+WQ1nolnQv1vep5DnOMtzt18IezipFgDfy8PvMx0k6t7bVz+dxww+JlSHch4a98s+r/cvd8EeaygOMie5UrZ5ELdo4CQ9V4l2IxzyfaKBuV7IUihISMtemebIzYuN0Xcw0JIA40nJXExbArfnyYiE2X1nN+PHvaGICYZVX9XEHZPA9EkeJEJvH0m7Km9igxv2xdmI8w8OnS9iB6Nkfs9zEbBTP9U2AfDJGoF6JNDbjdOEnqwQRkNLZAyMBdu8NSBCiU/NO378sBAbdoJ+1mtz12B+6XnzvRXdPC8mqoL+dw7RPpl/EIPgOmCTRMFeB2eLE+VNs5yZYpmkarv0o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F39A9DAD79F704DBBF0FC0571D1A1D0@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af98009-8590-4736-9068-08d7465da2f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 10:53:48.0544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pyrwfGd1IhF6UvdX2iA00qVkH/buzO4q4+kmF6idJdtkbrlogBAHkNkvYTAsvs9XMT3YUfowbrufzK3r8fa8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3261
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_05:2019-10-01,2019-10-01 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 01.10.19 12:25:39, Borislav Petkov wrote:
> On Tue, Oct 01, 2019 at 09:47:07AM +0000, Robert Richter wrote:
> > If you move to static inline for edac_device_handle_{ce,ue} the
> > symbols vanish and this breaks the abi. That's why the split in two
> > patches.
>=20
> ABI issues do not concern upstream. And that coming from me working at a
> company who dance a lot to make ABI happy.
>=20
> Also, I'm missing the reasoning why you use the ABI as an argument at
> all: do you know of a particular case where people are thinking of
> backporting this or this is all hypothetical.
>=20
> > Your comment to not have a __ version as a third variant of the
> > interface makes sense to me. But to keep ABI your patch still needs to
> > be split.
>=20
> Not really - normally, when you fix ABI issues with symbols
> disappearing, all of a sudden, you add dummy ones so that the ABI
> checker is happy.

Let's go with a single patch then and the function naming you
suggested before.

Thanks,

-Robert
