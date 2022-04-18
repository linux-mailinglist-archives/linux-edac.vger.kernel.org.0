Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421B1504ED9
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 12:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiDRK2n (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 06:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbiDRK2n (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 06:28:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862D01582B;
        Mon, 18 Apr 2022 03:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gfzwpj7UFakha6ITtM5bYBFjAZ+GR1XwwiTS6M1tf+RsvHQG7HjOK/7oiihIzSx1O/UU7kThFFghHNis45LjSyjFfRMX+wHUQWMwEjLdk9Fi+j6lK4M0lmqIAIwzvXgfJJnI6vqcWmU0j2ZPx5dgCOblPCg5tKDg00fKI1Q306qskfXtPObcSbHhLZxR/Djiv1+n/idh4fr/PO2lOjaITrko7KVZAMRFlLsD1xPwCZRx9o3WNbsuTsGxGH+a29Ir7PWadi3G40m02tN/E5wHBLIypM8vlpf50DZKIdaf9qoVGIEmoNPMgnREPkr2/pZIaSMmgV2KiLV5tcowi8LZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9ogTeyXuWzJ8Tuiq/yztyqWsUNPd195E1FOoQWZ/w0=;
 b=d5AylrV5hTIjw7aTj9DsBHTA4hjXxZwIejKP/sQKakzj1IKX9zfs+a69PiruXeXFLWozjwaYzDfZa8sU9JDYNx8gvWYnHyyoOxzOopz49itsNOj/NEHy1ygHRHPRQCXVjeBEnEGejvrAw4ZqxDy4l28RZh+lQk3q/X8hSqicn1wfKtEko7QCWiJVeFe53Nozlx3DJvhKAp6RtzNyiWJtebudHrPG5uAK7I78moVKtqlKGmcQ3gt3wT/A9JHsjsK3/GInIB/QTv07CBkQOKK9DGH6NzAWSgJGF1pDWKOsa4+M9uHeJ9QzeolsbOFwY3wB5sR18Br2JPFsoUf5zo+SyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ogTeyXuWzJ8Tuiq/yztyqWsUNPd195E1FOoQWZ/w0=;
 b=nADBnUHBcIdH7EJjaA2nWhaF8jvpbZXIQVb/DO4Yzdk4C6BndUHgdJHq2qkSEDhaNjWBdEa6ST/38A7AHCmcFdm6vYHJKU4hvL8TXRqJM3MiY9yclhv0dFVA0C4Wy9WsxsBlxjXBooMGYswKcgm0PFEPSAFEfvbnroQu29z4nVs=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB6328.eurprd04.prod.outlook.com (2603:10a6:20b:b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 10:26:00 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7df0:c9b1:13f9:f712]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7df0:c9b1:13f9:f712%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 10:26:00 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver
Thread-Topic: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver
Thread-Index: AQHYOrogKpzqNHgd/0yorlVfqzVePKz1IMNQgABoHYCAABpVQIAAAxKAgAAAwhA=
Date:   Mon, 18 Apr 2022 10:26:00 +0000
Message-ID: <AS8PR04MB840482A6529F6346FAD4687292F39@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
 <AS8PR04MB84044DD3E5EC879F7C281B9792F39@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <Yl0iqXnsFm8rMBms@zn.tnic>
 <AS8PR04MB840435F6BACFF0C7F9B6D90792F39@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <Yl07U34H0V+XM8aV@zn.tnic>
In-Reply-To: <Yl07U34H0V+XM8aV@zn.tnic>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cbec649-0630-4151-d0f4-08da2125d585
x-ms-traffictypediagnostic: AM6PR04MB6328:EE_
x-microsoft-antispam-prvs: <AM6PR04MB6328102FEDC4C4B3199DFCD892F39@AM6PR04MB6328.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6JUXnZuRCkCMGTpbAS+V0sAAlrzKxnFDdIrl2YGUaaEqN6msQMbUKRouKwRP/rg/zKBM/uSvPvNAlrz24vmepk77RitEETkxHG5Ntgljizn5tFSZU6DtmFzYKBXMiBBcsYVIMcEmo2V9Wxp1sdpxmHYJfaghP84bkok6lzp6b9HMSMcfUi60dpWYPq0qEZeCuyau8dcnJohUtO/8ARkXB3edb2M9NOxqOuYaI69pSVymoTtknrNhZiERX1kA/lAtLHoBIG0zAfjS0arcoprOLFwboayxBL0r5LkC62CBjNhNnxu36oaia5Wz083HgjrfWWRJ8i4m26cq1QUSh2X5VstONbpTwZAkZeOm5mPYiYlJ9AAg2cjwOMiSYZm1518YpjoWlaTjFtV/V3fET1UgwbpvbfILN+Jkxc+2t6nVkGrLGO4O1Rz/5mOwUD9g0uuE6GSo6DjFaIu0uoyKMp0zbYFd4014mxEuwBg6wP3SMxVSQP8IoVb1ezjn/iZODehStPANhu8itdNgvupAlSYwX0R+v3za8oU1PQhA6DWv/besq8xzg0hAXcvwS8m6pknGz2eS4KFDs4M1NCu1OqmamUFtLwJh2mB2oLSFS6J82ZKcBcSKWRyU9GQdH7PDHX4D1G0wXMZei7sO6KKtakQfpCGZlGOaRQtJwDUyYNfludifex+H2kiOMabNEx8EInYNBXfqO+SHapq3SjRVYdSEeNcmyEjGVeBC9z25kPIlsND8O44Wtp9Te0hQfn3WwGP7boKRLZIw9Fq1QTfrelzQHvsxH5bvNuKL1HGcDYYK0Ps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(64756008)(66476007)(66556008)(66446008)(66946007)(8936002)(508600001)(5660300002)(33656002)(4744005)(45080400002)(186003)(52536014)(966005)(44832011)(71200400001)(76116006)(2906002)(86362001)(8676002)(122000001)(6916009)(316002)(54906003)(55016003)(26005)(7696005)(38100700002)(6506007)(9686003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yWsRAhU+BObiKozagIJqbkUhlcQG7ZeZGKOjoYk2tJjChHXXlkibmmZBmi3I?=
 =?us-ascii?Q?GqeRrbM2OMhxHJgYcsARy/SxFEzojh0sgoYlfRk5uqAf+1iEPMh/bXELAgfL?=
 =?us-ascii?Q?qeDjtXXdc7fz3pJ8OZQ0WF4PC/2qN2lWjZkV16mgBT8gVjqxHzD8t7/zAYMr?=
 =?us-ascii?Q?zRQGKlmiyiCKQ0BunpDVMY+fL6AIaWdXI3V1bKXphDJTibwsUtkEiuNu09zs?=
 =?us-ascii?Q?DY4HFGL/eqVXOlk+LJRVJCbqFMC4RP5LWiN8ct9Ew/+tflKWy8wnrt0P69eC?=
 =?us-ascii?Q?rX3hXt+NsU8mMpasAklcweHnRfkioVknDvuc6MnwgXnVuGDdsKbiqCK6po91?=
 =?us-ascii?Q?H2HGIsUAzv5w0yCMxcl54KAg3TSnbOucvS0CEdvfLKFQ2bFY9yqXpfq0zE+I?=
 =?us-ascii?Q?qIdX1QOvmzr7vhm7V0AudhdGwLBApoAxKmJETV/2dhyMmdX39z2PBQ/e5msH?=
 =?us-ascii?Q?FOoDiKatilpABuYCib+QlbIORbOE12hNBVEk5gXH6cM3rZtPjix5i7ZVZatm?=
 =?us-ascii?Q?N8VGtuNXSWEb1wgtT6CStFQVMeF+R3t+6tk1HiIwFH++rqgtBKtoP/yfU8Ec?=
 =?us-ascii?Q?2r5T9M9Tz5TPGKx6C5xMmM+0qyXq0X+WPgw/ZxOlL1urtWFHnCP/ng/i8mU0?=
 =?us-ascii?Q?oZ5TvMl3iJHBM65xcHV5g/BnaegpDjjgj9TWQguzGenNMIqnFK574LwkZ0hD?=
 =?us-ascii?Q?MTOqeLsCurKtUQewLJYpiMBM5lusGK3o0+UlrUuNg3STfm0PNHdAqnsEOWuQ?=
 =?us-ascii?Q?391p6giu3vSDrzRBnaXN8MnwHNNoJCRoiG3OXHnfX6Glk8l2MWqa/tk+HWbF?=
 =?us-ascii?Q?DuNSjQ4CBsPy3qOO0a4NlMomNpQts/fANsb1eo/702zQY9GkQsJ3UXtlP09n?=
 =?us-ascii?Q?68O41jZ8TDmRaPLjAUqF121RYADFIZqCob6IxcFhMFYkKsbq9BLXgwIjMkOv?=
 =?us-ascii?Q?U/9J+ORSNYVqRzwXSkGQ+2xglPlbV3CtlkkwXTfdDE1FV+ktk3S+pnOyv4ji?=
 =?us-ascii?Q?AVqyEhDAuq71Bbtm8h5tUYThV324qRT4P/6aRGTOOPkXIqSsKeM3mcOc3sgn?=
 =?us-ascii?Q?akn1N+LA0HU8To3wGAQqreO1ExxWZMumHhZ50u7WCqQmp7TplLfZbiHqxOHt?=
 =?us-ascii?Q?AhcowdR3u8PKsMn34cAQmfWEpUlVDzmfgYBfy2Njuesxqqwn8weDZyRmU2ms?=
 =?us-ascii?Q?aUL1Srg6zQLqtr3/ypTN+HAVAck0U7IZyB9sttHqcbqaJqNugfT3bS4aA4Ob?=
 =?us-ascii?Q?AX42Mn3z4cKD1YOlJ7fGOgW274buX1s/1Oa+nSWAvODsR0e9DFRInaNICDfE?=
 =?us-ascii?Q?vgqwlt8b11ugKDJgnjqKAlzzMXbNIEjCjGtT+sJ24k817PTxSWHCf3KmirFB?=
 =?us-ascii?Q?ECJ/TNoS2iJkia5s700I8HB+km5DK/5Qby0So/kMu2jpqKDZ3OwiR+jNRgWC?=
 =?us-ascii?Q?CubMKHRbbmvddFRKz5GLKe1r3Xo/PvTkbkZoAdNeIOOwSH3rsUv7D8sWhKJF?=
 =?us-ascii?Q?fKenEUYqkBfrH4lKLC+tnGnCumq47r7T6RRNSf9v4t0OF/ouZ44roroLbDrE?=
 =?us-ascii?Q?VnRfaaQ9KkRWFM/bpAGa/vY+1GHKvyV/5jzlZLbXsy8zx7Sx8PUIbn4zTly4?=
 =?us-ascii?Q?rsn2ySo9KjSaMyGbBatFHy5HRMrOM06xRn+4Dt9csK3381NX7GOiqyLW+KB0?=
 =?us-ascii?Q?zo3fW145xc2iMNAuZ6jyUBYk76gifkmqTxA6tsPbc0i0RQgjgaN4mzYI6uB1?=
 =?us-ascii?Q?Vlj4YPqQ/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbec649-0630-4151-d0f4-08da2125d585
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 10:26:00.5843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAfkZT5J2vHZYuwDDNLpFvnnD4kb6C5ZS/vTFYloCEbA+ASXJ9vfEQMBs9jWOp8u8PRql+RS4MbWVlzSsLtOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Subject: Re: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver
>=20
> On Mon, Apr 18, 2022 at 10:12:14AM +0000, Sherry Sun wrote:
> > Hi Borislav, thanks for the info.
>=20
> You're welcome.
>=20
> I'd appreciate it, though, if you do not top-post on public mailing lists=
 but
> reply underneath the text you're quoting, just like I did.

Hi Borislav, sorry for the inconvenience, got it now. ^_^=20

Best regards
Sherry

>=20
> Thx.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl
> e.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf6fc1ba92cd
> b48d974ee08da212503c1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C637858740108440664%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp
> ;sdata=3DaCaTdGQ5BR8uWgOOboJkR3rd5kbdB0Q2yCG7wLd%2BjL4%3D&amp;
> reserved=3D0
