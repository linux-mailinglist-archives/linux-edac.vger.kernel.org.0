Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6DD327F
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfJJUgt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:36:49 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:12438 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726710AbfJJUgs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:36:48 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKYSuB020527;
        Thu, 10 Oct 2019 13:36:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=JQPRpQKqlFRuh2fQTa9U3ta5TRgZo081T1imlkpPhu4=;
 b=YFrQ9Kr4Bb01XnjFc8Z9O4AXjDH+Z6jsapYPIsqth0Ygv0myJ2uml5ql1IEr48XfqllZ
 TvXQiGqY0+2AQPUpLvQqcdO7VUfLc+8gorq+DbHruqkqqsHRA9HVNXmEZrG1HkCH87Ih
 JPokbf0pcfutYCzvTRfq4mHvXXuCaoUwdWRuNaXqcaPoSZraVcHtw9bQhoQBAGcXNWum
 ZflRP0W8aDcMSL/4HDYjetw7ErRAY9vpTLj+rKlTfxsbdFYD1k8Xqtq3II8LCQ/6SvPY
 DdpW3twUjI95ft5LPMlkDPi8yk9D573gR0y2Df3BcGY2UBIAIgs/17rtol/YG075RHoQ Vw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vj66h1hjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:36:34 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:36:33 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:36:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJNW8ZkcE5uoIcSurj8JNcFsbcL3hKRUnZW3UN/+UoQ2WcPxOYm4iFGZ+XIKsc1DdTdUB4gKvQ47ZJYAxWok1l03/OM2y9/FN1tj4PJw1Onw79tPqcBKwp3ZElGp0jXcKGmtPGbYxZG9F9ffs3tqSykavvdiiCDD0kRpdprulY8pvf4/hxvl8QQCRHK4ureG32biwMXSae8FknI62YzrmZWL5Gm0lEdmey7gTp7MiKhwkdmz3zPpZTXU/r+Ynzy58HpEP58W2hEcp1L2mOOvB6KVFlwaqfWuBLJBKeRC5ltLm/JrLWa7ldhV49fipb4xjYZkkZnf9gJcwsFRPX+2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQPRpQKqlFRuh2fQTa9U3ta5TRgZo081T1imlkpPhu4=;
 b=YINj5bS4opv1J4gJS+H31f7u+uAFZ5cbu+4IZfeddjb0jJDks4VTOR+fulRCjlpLIigCO8GIB2fWXUoWGMAZZegIVfvPXB/slrBIWlVOBNI6/MovsUMOJSix603M1+F6KaQivlqZNbGImxV6eLWHdpavR4GEIdsxb9YHhXdNTI5Zc0FLHS5hKkGJ5gO2hd3I7Ajm+n/g3CFc+TTcOXyLBXchoa9Bzhx0VBKatabJGICwRbLnv92pcnAfhEuIwgEFlfNoSEXYcMhPm8vm3sOq4Px0+J7KbAvnpFdVXdoil5jwB7wg6bEQG2WSSXE540UcO7mLJlUiEfJ8UNL9Kgw1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQPRpQKqlFRuh2fQTa9U3ta5TRgZo081T1imlkpPhu4=;
 b=bcfq+yK5cjy/5lMejT1RZ8fH5w1wpIRs/raDGKAyHTal6ZA6a13C6fvPSKS2ASk13NRImA27TOJmv3pvhTEKN8t2b9nN9tJq3RTILPnyxUINiYwhQBMjYUftF8Pmrg5FnUMl9fwzIvQqFLe7qVJVOJ+UvUgP/YwarfyTOvl5a3k=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2765.namprd18.prod.outlook.com (20.179.22.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:36:32 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:36:32 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/19] EDAC: Rework edac_mc and ghes drivers
Thread-Topic: [PATCH 00/19] EDAC: Rework edac_mc and ghes drivers
Thread-Index: AQHVf6jLshPLJWnlTE6zMo1DcW8g6KdUVXCA
Date:   Thu, 10 Oct 2019 20:36:32 +0000
Message-ID: <20191010203623.z4u6dhxdv7kp2na5@rric.localdomain>
References: <20191010202418.25098-1-rrichter@marvell.com>
In-Reply-To: <20191010202418.25098-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0011.eurprd03.prod.outlook.com
 (2603:10a6:3:76::21) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be9f38a2-e3bc-456f-9490-08d74dc18906
x-ms-traffictypediagnostic: MN2PR18MB2765:
x-microsoft-antispam-prvs: <MN2PR18MB2765B7474469AEB35886D361D9940@MN2PR18MB2765.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39850400004)(396003)(366004)(136003)(199004)(189003)(66066001)(9686003)(71190400001)(6512007)(64756008)(71200400001)(6486002)(66446008)(8936002)(1076003)(305945005)(8676002)(81166006)(81156014)(6246003)(4744005)(66556008)(66476007)(66946007)(99286004)(4326008)(5660300002)(76176011)(229853002)(52116002)(86362001)(7736002)(186003)(478600001)(3846002)(102836004)(6116002)(386003)(6506007)(316002)(486006)(2906002)(14454004)(14444005)(45080400002)(256004)(26005)(53546011)(11346002)(446003)(25786009)(6436002)(54906003)(110136005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2765;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ALL1BehWy8+EUvuof8AuAZZ+rt8uAieusnB8yN5VYHl/WCK+M8/KLQNIpLur/mX8hTOoNHOOWVBCYdfAokUMS0TU5hF4B/f3pNbmeMXdDVllMREKHKDOCY9jRF2uKx2WQCEyK4x+i++z9vaipkUWkRndLajPoWeZE4faHAFHtlHIbDU0vu9kxFmWjQoO8gvmciZ3jMpPM6tmyMx81w0Spm7Jc9rXXD9R2UV7JSfEJVKTxeunqt4xbkelwBvFG2LZGXz9dcYJq1pVH1vbuoJSyYil088ZBZU59Nnf4VbP4nvqCAcR0cqMmsOH8paXJQbbjYHJHD75mcFdGPjoEm6eurFL+zg8TKp/G5AKUROUVqWoqd2j5MYTmqekJc3Un4FSuD/RYedHZtKGyZOVGR4cWIpqGf7jerG3bNpFktwLnsY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CFE2099D8BD0F40B4F53008557AFA20@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be9f38a2-e3bc-456f-9490-08d74dc18906
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:36:32.0820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rA4YLW9XENquj5xIybUg9ppGRyL1UKl8XU2TYyu3CjFg5O7Njk/r9t/Xhiz4PTpC6pCReATw9JeXJ0sQcRwEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2765
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10.10.19 20:25:01, Robert Richter wrote:
> This patch set is a rework of the ghes_edac and edac_mc driver. It
> addresses issues found during code review and while working with the
> code. The changes include:

Sorry for the:

  Content-Transfer-Encoding: quoted-printable

I definitely sent it out 8bit, but thanks to office365 this was
converted (IMO this is according to RFC but still a pain).

I will switch to another account for sending patches in the future.

-Robert
