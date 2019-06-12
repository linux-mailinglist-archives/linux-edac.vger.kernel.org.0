Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D590442F31
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFLSlW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 14:41:22 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:42084 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728841AbfFLSlV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 14:41:21 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CIe553010654;
        Wed, 12 Jun 2019 11:41:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=q69tUFXGTMDPBEuA65P4J8macASm8wq5wpAC3LFkPXw=;
 b=SWCbBqlOuRj6blSWnZjjC9VBX6eaSadMU4F3dfOdmzqBVdCUYQuucsi80051mNPpoR0X
 RteONXNihAwxTK8A+Mdl2EBUpkNeTQpS+KrFnhUjyRRHmNHDeWJT+6EULbh7/pe6iPYk
 VkCfNHYAreweUWNhbJmJFXDUFy2K3lmOzLW8Cn3AnieE3qaQOHcJyKb2pgaxyaZymWrO
 fm1eXwnLqd7+MBjCxwBCkYhmZ2eptAyerDRgcEsJcqXtp7TOqW64GVyQ00xtgxfZMMOJ
 H6oYWuKYFux+CXIsSNDChMxPe6abDg4Z7Ci9L5kAEtqEGP0dlQiYBxmSTSZ15SqoG4OO oA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t34ngrk97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Jun 2019 11:41:13 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 12 Jun
 2019 11:41:11 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 12 Jun 2019 11:41:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q69tUFXGTMDPBEuA65P4J8macASm8wq5wpAC3LFkPXw=;
 b=p86ox96eoceuLClEvLS2F2HuTNUnoqYN+exLCe6i+8LaFGViSw8jCjjEng8D5W6AiMTl7mOK4xJoqrbbEfJ7eVx1BY4+aD1A0LeRXXdmH80FExfD3rjJe8DgbEWYYr0Mzuq1LeEYDDXR42GXEVBzq6kHtqfhQknrupm1zzN+E/s=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3087.namprd18.prod.outlook.com (20.179.20.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Wed, 12 Jun 2019 18:41:06 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 18:41:06 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/21] EDAC, ghes: Add support for legacy API counters
Thread-Topic: [PATCH 12/21] EDAC, ghes: Add support for legacy API counters
Thread-Index: AQHVIU5kX5MqKG3rJEqHTaHdhQcplw==
Date:   Wed, 12 Jun 2019 18:41:06 +0000
Message-ID: <20190612184058.2plbdweri6bjmppr@rric.localdomain>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-13-rrichter@marvell.com>
 <92eda11f-dad9-bb2b-3a87-80b6c8d8e228@arm.com>
In-Reply-To: <92eda11f-dad9-bb2b-3a87-80b6c8d8e228@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0027.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::40)
 To MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b267bb12-b4b4-4cde-e4cc-08d6ef658723
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3087;
x-ms-traffictypediagnostic: MN2PR18MB3087:
x-microsoft-antispam-prvs: <MN2PR18MB3087AF35AA34273B31632F07D9EC0@MN2PR18MB3087.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(9686003)(6512007)(71190400001)(71200400001)(6436002)(7736002)(305945005)(66476007)(6486002)(66556008)(6916009)(229853002)(66946007)(64756008)(73956011)(476003)(26005)(186003)(11346002)(446003)(486006)(6116002)(3846002)(66446008)(2906002)(81156014)(4326008)(81166006)(8936002)(25786009)(53936002)(6246003)(66066001)(86362001)(102836004)(68736007)(99286004)(256004)(52116002)(1076003)(14454004)(6506007)(8676002)(316002)(5660300002)(76176011)(53546011)(54906003)(386003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3087;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: di3jjJa9CtGR/OeWpQeP1vXQeZa+w+q+s4r6XF7hAwm4D5havUBznWTMSJLjLAk14qk9wQ3Q3wS+adPBn3XKbba5r6v++qVQ3Ic8vCpX1BLjbeha/ObIhtmJOi9Ir6BZEknUt5eAr7ilaFKwE+pSdyWUomCHIm3Bp2j0vjSHvEHkTachCKs3xc84cDfVMs/IY84pm9rs11Rc+i/4uT73Nz9+7J5pHyWSDaf7bT2pLQrY9cA0DkawOv7vfWjlQ5trOPu+CyoGH6d4g5jlmjhwA30W7TUPFRNxIympq5w/WAOoGz7hYiKIE1+RxxtZoeetzm1PAOrUyVSPL7Z4GkzuKiDVYTkWgecnGztS5eD83vHjRKMSpUO9t4eIlVXFPJn5i4s3jxbxUdpms9UkYGA8uwQvrVaXBGkj/FJPNxKo/Gc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D67A621340DCFF4590CB9B3CBC5583E0@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b267bb12-b4b4-4cde-e4cc-08d6ef658723
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 18:41:06.2163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3087
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_11:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 29.05.19 16:13:02, James Morse wrote:
> On 29/05/2019 09:44, Robert Richter wrote:
> > The ghes driver is not able yet to count legacy API counters in sysfs,
> > e.g.:
> >=20
> >  /sys/devices/system/edac/mc/mc0/csrow2/ce_count
> >  /sys/devices/system/edac/mc/mc0/csrow2/ch0_ce_count
> >  /sys/devices/system/edac/mc/mc0/csrow2/ch1_ce_count
> >=20
> > Make counting csrows/channels generic so that the ghes driver can use
> > it too.
>=20
> What for?

With EDAC_LEGACY_SYSFS enabled those counters are exposed to sysfs,
but the numbers are wrong (all zero).

> Is this for an arm64 system? Surely we don't have any systems that used t=
o work with these
> legacy counters. Aren't they legacy because we want new software to stop =
using them!

The option is to support legacy userland. If we want to provide a
similar "user experience" as for x86 the counters should be correct.
Of course it is not a real mapping to csrows, but it makes that i/f
work.

In any case, this patch cleans up code as old API's counter code is
isolated and moved to common code. Making the counter's work for ghes
is actually a side-effect here. The cleanup is a prerequisit for
follow on patches.

-Robert

>=20
>=20
> Thanks,
>=20
> James
