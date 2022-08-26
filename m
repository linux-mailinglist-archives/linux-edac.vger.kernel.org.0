Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036205A32AE
	for <lists+linux-edac@lfdr.de>; Sat, 27 Aug 2022 01:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbiHZXdO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Aug 2022 19:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHZXdN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Aug 2022 19:33:13 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5018EE3C05;
        Fri, 26 Aug 2022 16:33:12 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QKMr8F027352;
        Fri, 26 Aug 2022 23:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=EMuIe9ZZbH1jOi7hEkvbn0q97i1QLVuGZ2nMSeVvCSs=;
 b=iv2dpXOjKuGFlTHb/iLYipWIjgX9MOYPHJE6lkF869bfT0DwJteVXoOsFQfN/LOqYx5A
 nD15/IbDg9++Hc8eRGXnwO7JQZaqicFsRnklhFF5bckgZwdUuB5H30MJ8zk1HiE91s3f
 Uz0JnVHEW7uiScFyHik3aB2Mnib2+TNRagaM4QiFUUF1FuNUpIwA5llpo1HJ3UOuY9xS
 ORLLyj5UA9hkLeuIKR+ag86b0YwThWe9d8kvVaJ1QKBYHYhhRbxwRIjbK/XsNehraxl8
 a6wshboCFKoXgDrBvnm9IJ5FzIzeUyB3J+VvFNEplhCK7/Gez2NURmxyfqwGlrZM2LU1 5w== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j755e17jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 23:32:38 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id D37A8D2EF;
        Fri, 26 Aug 2022 23:32:36 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 26 Aug 2022 11:32:36 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 26 Aug 2022 11:32:36 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 26 Aug 2022 11:32:36 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4UtqK3HP6sW6oHx5UDUSfGwsTqw/Q8lEYmHGW8tmCWhdI7JsM2TyujxGeDMmqAbPNVVgGAAAH5f1jWEbgBvps98mRWEpb7eOi2kJTPs0tW9I2XvlgwbhbFuspoARisfoJ7oq+gQ3XpV9CFtW6e9+sYZ17DyXUETX4M6U7CQK2lNULIPPBEJ568GedTBazJwg0YghjCUUnl4a9p63QiYc/ji5Ervo8CTU8X8nxUlA1Dd9r3KrFhNVOKhoFwcmWydKRROu4x/MtqVbO6Uof4ajw+jKZCg+wrNRD5Ri9xzyQTPpkqrOpzryuin0CisxJXtrCnuYG0gY5g9e98FnZSENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMuIe9ZZbH1jOi7hEkvbn0q97i1QLVuGZ2nMSeVvCSs=;
 b=LbwYHq0U8/P81LbxCDOfrGySU56ZNRjFObVTqH1anYmivrjq8hsj9mhte7poQQ4fDpVIsggY4z4njLjhVUHNPL4vLwMAFk0TVPkTbwABAB+iG+2zAfFDUcUQh7p5N2whMkQIKLUVfvkC27ZODSK967ULd7HDwx0UE3COn7/JYYFoabYkcygzCQWFyruyKSmWc3aXI8t0pSCUgyQuCzyCfOUGRFrqo60opwrDRp5Jvg12QCaBDLGZZIQ5VGkuj+Kj2K7ogIAjRbjv0W6wwyAHU1dUD5aCpwfDnTMRD96eOrtgxYpPE6IfzjTuyrqjZSQM14osSlxyvB0uRjBt5MLfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SN7PR84MB3253.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:806:267::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 23:32:34 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Fri, 26 Aug 2022
 23:32:34 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "Robert Richter" <rric@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git@amd.com" <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: RE: [PATCH v3 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Thread-Topic: [PATCH v3 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Thread-Index: AQHYuSE0bHg8dcfm4k2jocyxIFitxa3B00Eg
Date:   Fri, 26 Aug 2022 23:32:34 +0000
Message-ID: <MW5PR84MB18420EE64EA9B9FCD2E3ABAAAB759@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220826075332.30609-1-sai.krishna.potthuri@amd.com>
 <20220826075332.30609-3-sai.krishna.potthuri@amd.com>
In-Reply-To: <20220826075332.30609-3-sai.krishna.potthuri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c998b178-cf16-47de-d607-08da87bb40ed
x-ms-traffictypediagnostic: SN7PR84MB3253:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUlHlrLa6hI40i2YGKWqJ2B5ZJHjy7csIozRvOLNxrSE01h+Wz54jW5nDqq4aJL/FROhyZ7QWYdNfJ9TIsGdmVkqO5T0TMiqFzrRqveiDjL5iBZDUNN4tUaJaxiXuITigpViDBjJVq5FzQdyedb+dmVDpolCa4oR4tk92iRURCZPZtymCunGnpH3pF9ldfz+vd9LoktVX/EuHxtN/64yPeh7B8KMpGG7HHHCqpBnTSpoD6tEE74fuI8X7XaGWwR35Bzx6R7Pa0vESyXNe6AjynE5Ycu3evgG+YS/tv/W2KiUJDOUKU9KJEL+M/ewL/y+W0Qf0hq2AdleEZmnIgd3/HU5+PM5AOImtKJemFBa6HI20F3U9CVz8b9gXBujiftW2qYysnNJ/bmikgrmHm/+YY6hiqlDLPWbhVKQL00nx6aurdupyAnOl6+QtubcbdlPjQli4pCdycjkBk/OYMdsseEG0PI+OiM3c759e2QVnJ9jCNCc2r1nrlERiiC4s0kZ3isy8rxBiMBr9s2QoxmI/Fd2EglA6sg0ohSC7E/L0tauj0U9u7Wq+3eMfJJOjZx3h+j+oVrxWMYyCIBisWp/utPVfWiBXj1AMLPmbs4sXR6Yuwl2MZ7MwFV7W+iAUPwBwoVB0DsiyswvtdQ1c4k79gwxcCtooPNpt9lSultS5vqdBlzJ4GZqKbJXBRLA01xPEt/Gi1JdmiNNlwHqnIoOaqSx8Vpvo5npjduF3YXQwC9L6pIwYosUToUgN3DXC2UM8RxSZPgSpbdZ2FKo4IPgiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(366004)(39860400002)(396003)(4326008)(9686003)(66946007)(64756008)(66476007)(8676002)(52536014)(55016003)(66556008)(38100700002)(66446008)(186003)(8936002)(38070700005)(26005)(478600001)(76116006)(33656002)(82960400001)(53546011)(110136005)(122000001)(54906003)(45080400002)(41300700001)(86362001)(2906002)(7696005)(6506007)(71200400001)(83380400001)(5660300002)(7416002)(316002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AuHtyIEeNdcWejjU9VrO4RDTngtsgGXm4b2jFh4sJJmWDV10L7WJSAaT0pEc?=
 =?us-ascii?Q?p0euQkhsmZVB5saJzZTloQIkXXNgSYUPDxT9jQJ1L4lhCQt4gb6m88p3Nct7?=
 =?us-ascii?Q?WHn+MRbukX0S0KXi7wrcFK2m63oNDQjq9p8ggO1D7jdLSFb4TVCkwHaBUi9b?=
 =?us-ascii?Q?X+Bi5PXdLz9rEq6jKj5BEnLh23ju43IZR06jPB6/rVXnOhHKBwORX+7URfVM?=
 =?us-ascii?Q?98TosOFL1sfj9jSvKQarR792pNqQqmPXnSNC+M8BU24HBaBlV0mdrx3QX00L?=
 =?us-ascii?Q?ju4WnxVjhI1ajS1+vjNxIDXCj8ndCVUpI2Z2LFRsEiOGVaYRJK5ydSZ97ENw?=
 =?us-ascii?Q?jDE9VYkruZoDLZxhQ3G/1T+tsMuWDZfW2VJDx3mHmMsfTHk3GLHfdD1WQDDp?=
 =?us-ascii?Q?oLrMUS/WV+M64TcH18UpP3UbpFtxUA6+wBRi6K37qjvTX/Th/GspxnCr4Sl5?=
 =?us-ascii?Q?cPl/ZRL1Qi0w9YtFowXLakF850vsUQD0uDAoBiFqneDUzVSOMN+m2ixYYfoD?=
 =?us-ascii?Q?Xv+6HaRDw2LoXoCKOt3X7QldoeeWhdLTVbQeaoLWY+hFlUJDvrQiGexPjF9L?=
 =?us-ascii?Q?EX43TpNCZRbIa50l3DHFNlIlPZoAeOLbSQWoHWiftWOs1i94+86eN/zP28+r?=
 =?us-ascii?Q?74vToLJO6We7HePSnYSKlkwuqCKMDBxfFw03rvWRQrAjR03EA0qW2/16J8nu?=
 =?us-ascii?Q?e7tRFE9Ae659CEO3QBzeeOUhi1s5sW4RUO9N0i5OXg3z2qQSdCR3glu2V1SF?=
 =?us-ascii?Q?5UqhMcyrU8aEkpfSjxfmu6i6Bp5vN6vouRkKDRHJ+rThCi2+CqkfbjF2bOI8?=
 =?us-ascii?Q?sdhy0tXO/1ADq1iuuOwFc5+xUAXL8LDnqn0PLnyhZjEmmCw/LcYnXKMT2P9B?=
 =?us-ascii?Q?86fo86QWKVL+lzpX6lIMJ2XoYMUdifZWo6xAwddIAPhwk+0+yvjYIlDdehsn?=
 =?us-ascii?Q?JPGeR1pO1B0k3hycq5vQc7V1SHqivr6S8eHQmhXTVwiJLqMfmqV4C6VnEzlB?=
 =?us-ascii?Q?N8Yvz68j+8kFBtqSUh0cwhR8ni7yEajzmAvPFKzSg7wAZISLYkWaFev2NTW9?=
 =?us-ascii?Q?40LO0F1tRdottxxrE75zk7tsoJvR+bDsbqxdFWvgcdyQEX3ZsvITZBnbCnOk?=
 =?us-ascii?Q?rJs56Kyh/s5/W9jB4hT2wMZ1jtY8QE1DvwgRbcwZHWTPA0q7//wCqlGjoiZZ?=
 =?us-ascii?Q?+6nnRHxN7ksMEnJ0Sssf1obB5bV2qq5MFd9Av2vpuHsLZLkfBM2U8AeFadC9?=
 =?us-ascii?Q?XH4dv7x1G9940nwsT+ZhggDz3LKa3xm4AY611sbqAXVWeXQrASaFKExAD87x?=
 =?us-ascii?Q?hpxqX8JouUwkzmlWdJ0aFe7ZzCw/QC8JwiDRwnYdzFDKmW+fh2rFtdQ98ym6?=
 =?us-ascii?Q?9SsmDh9RKRsIRuf/PUOQnHTK60IPax69IMopr941Gmn7E1hOJJLhwm81Gcan?=
 =?us-ascii?Q?rLnFE/eZ6IrUsvrA3VotIa/uWkCtTQnYk+MFTC+m28wW4FFxfKsPetmTIDPa?=
 =?us-ascii?Q?wv6lX0X3N+yZgTAKU5xXBmuOny3lw+QOSnQNniF8YfMlfW4fKIFKkUOJWQMv?=
 =?us-ascii?Q?SC/18RAsnnfdhXBW83E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c998b178-cf16-47de-d607-08da87bb40ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 23:32:34.3839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElggKZFelbxT2ZPBzCsfP7Levxq07tdW/Dz1YITyJusI22e2QnZRTlyx37xjxDSr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR84MB3253
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 4xcDfzWyZT5IXbwlJeJ92getha2k3L99
X-Proofpoint-ORIG-GUID: 4xcDfzWyZT5IXbwlJeJ92getha2k3L99
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 lowpriorityscore=0
 mlxlogscore=821 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260091
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> -----Original Message-----
> From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Sent: Friday, August 26, 2022 2:54 AM
> Subject: [PATCH v3 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
>=20
...
>  create mode 100644 drivers/edac/zynqmp_ocm_edac.c
>=20
> +		snprintf(priv->message, ZYNQMP_OCM_EDAC_MSG_SIZE,
> +			 "\n\rOCM ECC error type :%s\n\r"
> +			 "Addr: [0x%X]\n\rFault Data[31:0]: [0x%X]\n\r"
> +			 "Fault Data[63:32]: [0x%X]",
> +			 "CE", pinf->addr, pinf->data0, pinf->data1);

What are all these strange line endings?

Historically, Microsoft Windows used \r\n, UNIX and Linux=20
used \n, and Macs used \r, but \n\r seems completely wrong.

