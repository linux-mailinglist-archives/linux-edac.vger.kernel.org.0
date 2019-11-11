Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F370F7802
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2019 16:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfKKPte (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Nov 2019 10:49:34 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:31600 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbfKKPte (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Nov 2019 10:49:34 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xABFjJ3h004336;
        Mon, 11 Nov 2019 07:49:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=FAl94MC/n27IZ5XJ9QuM+DK/yvqqA7oCA7wc4FRGNMs=;
 b=uPbRgUOoAeZvXgi15GLkotQmqq+u4qDsoH9cEyp+Q3Fosw7Ecqojri+rCbz4/3FHFpsL
 xv9cb4QDribb3r/nWCWNRyHkBNYbXkGJTe0OsZjvtNes4+F6irWMjZcJbG6YzXEjmIQq
 W06ItSyI2+xEiTZaflnMbxSYLbeXlOiG+FdyKwW/jD9qfVjy0GzCY6BQOY8AAPd+a7/i
 V0cYQUNFUkz+fJBtoFTjiJ9IGtul2m4K6IQ9MIC9APWOW39GSdQd+a2Xnr+g3ct3xC6U
 XicKHhuBSoIdHpnumH+RL8x7awK15W0SlaJmSDLpnUKOv/QXI/PghS/uHFn44I1t0lrO SQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w5wurps6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 07:49:16 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 11 Nov
 2019 07:49:14 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 Nov 2019 07:49:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh3kNhslP0OqCVMROY2TCipdxInN6lnsm/vbgaoDCjHr2UZh9TvOw1hvg9v8HOcjYAMUQ52J/AJBqtQP4yT99hgjBOMqcH/5pikgOpIp3xp/KlAsP2WDFEDdvi7oXAlKd46kYiEosYNxSJJiJtKL06uF1xUmKGy3SE0QWnBn/TQ7xTaI6ykbjTYgXiHPoiBiL/ciUEcGNCZclxAb/mpZQoNDfqPYntEpEI3Ar+/TsJ2JtC1Pi9Qr7T6IHVuSMhNlf46YqkgiA9myq1cKpuRKsADc5PcSXmw6X09yO58NQfkU6GnL42cI/uNsrvvPeynK27k5B90FBQtn8Tr9XzB0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAl94MC/n27IZ5XJ9QuM+DK/yvqqA7oCA7wc4FRGNMs=;
 b=bqMdJokF6xKRnCxl/YXAUX6LFkCycTcS9Nz36xmKdlv85aocOGHzeu/HCwGoHRHzILPB6/r98RWa0zL1CpirNFpPGYXhd033jmXEcdlrG7AJNryd1ZppKekMcmtawzmcnYc6T9gXXL2AIjc3vXfoSYVlNRI4Ecl3DM3EvKwWanqNpn85IQf5FO+VRCfUllFeej/Vc0pOlwwzql/EIkCsK5CvH59p+9K21UFRCuBJQtXJsdB5wz72psjd7noTv+C0yap6AGWlGPTKpCXdjT9wInp8uLr2snG4xYl3ZPLy2zSDEr/ayQqClN1R0xUbbsOiNZLyyfWAbgytU/64WgmEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAl94MC/n27IZ5XJ9QuM+DK/yvqqA7oCA7wc4FRGNMs=;
 b=i7ZANvaG9+KEDCXcXMV1i8bII53EzlWcmW+W2Fh1EpN4QlbMFOjnNlDJRzXbUBy1K1L3KEzNPqVXKYy7RI+yo8UvC2lRTVxQ6XWza0AmX47rV4KuCd3HV02MVq1nbImdqMivFnWzuVxiMdHJtP4OXyeRzOUvcS3+k1mZDFoOMqw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2992.namprd18.prod.outlook.com (20.179.23.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 15:49:13 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 15:49:13 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/20] EDAC: Rework edac_mc and ghes drivers
Thread-Topic: [PATCH v2 00/20] EDAC: Rework edac_mc and ghes drivers
Thread-Index: AQHVmKeQMO6BEkFjKUGPpv2AlbZG0g==
Date:   Mon, 11 Nov 2019 15:49:13 +0000
Message-ID: <20191111154905.r72we7adnbjufbyx@rric.localdomain>
References: <20191106093239.25517-1-rrichter@marvell.com>
 <20191110145104.GB12627@zn.tnic>
In-Reply-To: <20191110145104.GB12627@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::33) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b4bac80-1dfe-403e-72e6-08d766beb2fc
x-ms-traffictypediagnostic: MN2PR18MB2992:
x-microsoft-antispam-prvs: <MN2PR18MB2992558CFA44DEBD9DD1BEFCD9740@MN2PR18MB2992.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(189003)(199004)(66476007)(3846002)(66946007)(6116002)(99286004)(52116002)(7736002)(14454004)(5660300002)(305945005)(6916009)(186003)(25786009)(2906002)(478600001)(66446008)(64756008)(66556008)(26005)(386003)(71200400001)(229853002)(71190400001)(86362001)(6486002)(53546011)(76176011)(4326008)(9686003)(66066001)(54906003)(486006)(6436002)(8936002)(11346002)(6512007)(316002)(446003)(476003)(81156014)(81166006)(8676002)(6246003)(6506007)(14444005)(256004)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2992;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6zW54iekPtjqubhc6pYGuvS5gAitoI6f49EVOtErbKrjFkGFT0hqXgsTHpUMtNFIjGpc2ns65i9iUhGh1f+MIAprk0Zm1sIsyhm5C44STLx/gJ1fB4TO0wkDpoIhDp/9maeZWD7aRAX5u7wSjGUlLc0DFySwLiwAu6Z27qFhnqaRjLo/V7FpMvMoXVfRpTK7SNCFQO2Qc3vmxWQIsVcEN9Fr7JVX9gM7nQzgo5YFbe/wvzEjL5wuwlXM5jA1mZDxjgNQFJTI4eklExJTV4oPjflses40clPpGPST2rs3PxA1PtMdREv1D7zawtnc+63e3RzCmMJ17DE7GRmqlJbTOsenwlP25KNKdGoLqCaHMdX/7hQ6gBQvTB31wtKEgAeqoUz2K0/KceLxKvkVI0ACM7HsVl+/j4JAyHqOVfAteQVsB6sveVH6hLYGBw6xGOFU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <441B402FB91A5B49A12DFC5DD557C45F@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4bac80-1dfe-403e-72e6-08d766beb2fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 15:49:13.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KImKXma1JeJFYQE27/IiKbYntNx+P1B4/U6xwsJUyvFHKp7ZWFAdSTDbi0V3E7XPvcbgPO4Cr7VJ3mmPh0Vqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2992
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-11_05:2019-11-11,2019-11-11 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10.11.19 15:51:05, Borislav Petkov wrote:
> On Wed, Nov 06, 2019 at 09:32:58AM +0000, Robert Richter wrote:
> > Robert Richter (20):
> >   EDAC: Replace EDAC_DIMM_PTR() macro with edac_get_dimm() function
> >   EDAC: Remove EDAC_DIMM_OFF() macro
> >   EDAC: Introduce mci_for_each_dimm() iterator
> >   EDAC, mc: Do not BUG_ON() in edac_mc_alloc()
> >   EDAC, mc: Remove needless zero string termination
> >   EDAC, mc: Reduce indentation level in edac_mc_handle_error()
> >   EDAC, mc: Rename iterator variable to idx
> >   EDAC: Remove misleading comment in struct edac_raw_error_desc
> >   EDAC, ghes: Use standard kernel macros for page calculations
> >   EDAC, ghes: Fix grain calculation
> >   EDAC, ghes: Remove intermediate buffer pvt->detail_location
> >   EDAC, ghes: Unify trace_mc_event() code with edac_mc driver
> >   EDAC, Documentation: Describe CPER module definition and DIMM ranks
>=20
> Queued up to here.

Thanks Boris. I am preparing a v3 with the remaining patches rebased
onto edac-for-next.

Thanks,

-Robert
