Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF3588096
	for <lists+linux-edac@lfdr.de>; Tue,  2 Aug 2022 18:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiHBQ6x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Aug 2022 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiHBQ6w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 Aug 2022 12:58:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF471EACA;
        Tue,  2 Aug 2022 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659459530; x=1690995530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5AvdPHZaFajqogbEdOilgrk1KvykAJsNd6yKpZTkTgc=;
  b=Z6tiJG0x1535/7FpdMfkX4JlbzZ3j3RIQ76bQSlBw9duy0tw+2PN1H0W
   yNCma/znXurlWZavYldG1t2TZenLIOtuGfB698CRCmHjWaLTZH9TloGwd
   G0a62aXg7u0tq2pJ25Bj/BgDnIq9PmO4JGywmAXzJBDp4tRN8qx4w8Xjq
   C1LXDiaxxdUFh+NUSRVIRo0/4GjIPZQ6+GCmUgCQeitaQJSNqBIacYVro
   j5YiUMjpnU3hDzYJJC1ygF8v9b4xXZ6t06jPhBBwh10JjLiXRoqapJX/h
   wBeJ1z4V9x79Mr9irFAl0Y+a3GRJPlBMfsSGbWdlacsBOqTvbl2gFb48O
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290680090"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="290680090"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 09:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="599361485"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 02 Aug 2022 09:58:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 09:58:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 09:58:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 2 Aug 2022 09:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrWWp03nOHQhJ/0dmxavBY7g31qaD1xR+Pwf1NdNzttirUMD1phXHnC4XLVtc8qGF6DWYTlERyyK+PFkx5iF5U17/LgAZtSUCrmQKjqkCYGX8rnOFayMiDKM6FuuTZ9oC4pRBmAj+rA0aJqAlIssX8p3oFkgqgOUSAef7c6YZ6TcoB+fLO+28Vdn5hWiX0NBe5fJjDAJLWaStv15JYGgVgF/JhTVZ5FzIwTeVIn0pyXmoBIDIbKEWD/zc5L6dQRknWxCBfquFNydXqWCcPlPsnj/uB9Bfq5GxmnhJr3rXonbrZu71TUdgE1zDDl297Ckikb2tCKdl7hMtiM89VAniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AvdPHZaFajqogbEdOilgrk1KvykAJsNd6yKpZTkTgc=;
 b=gt3bYEBFjsnU6o5aUiH4pJiC3qagviDoQDPT03SZtpe4ikvhoGn8MJ8+5YIscKTn7WbBzFGrBbGNe5JYscYr0+264fGsBGM8BSukbZwq+nQ6RUZXUAXY2wUNWzBZADvavEv2gXko/CpTMHpPJ9GXJ+0LrVoxgbTdXp09n/oXlzso1kuRB3Rsan/O1m1LGRqelnW/rTNxqJdBDK48sXsD11gzhLjS8rqR9pt17DPcLsCAy94kH1LcTtTM7ejBpQ21JLxJ4MC2sTmPCM/Lrk7rO8gRjEXXexgCOpLz1H7LgMWveQYy7FVW3qyZBjNnMH0BVlF/QOj4lgoX1c3LFjDM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN2PR11MB4382.namprd11.prod.outlook.com (2603:10b6:208:18c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Tue, 2 Aug
 2022 16:58:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7c8a:9ebc:e674:796e]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7c8a:9ebc:e674:796e%7]) with mapi id 15.20.5482.015; Tue, 2 Aug 2022
 16:58:45 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Topic: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Index: AQHYjHDb+eGrTrYjV0q4Ak2q6+c136159KGAgApwm4CAAFH9AIAXBOsAgABMvtA=
Date:   Tue, 2 Aug 2022 16:58:45 +0000
Message-ID: <SJ1PR11MB60835796448A4E04ACC1B968FC9D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-2-yazen.ghannam@amd.com> <Yr2CpuL+JHWblJMD@zn.tnic>
 <YsxefXQDCiJ1zxLG@yaz-fattaah> <YtUgb2Y/H/Wq9yIn@zn.tnic>
 <YtVlNrW58cFmksln@zn.tnic> <YukW/IltcCRwvSM4@yaz-fattaah>
In-Reply-To: <YukW/IltcCRwvSM4@yaz-fattaah>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3ac0648-333c-4c88-5c47-08da74a84311
x-ms-traffictypediagnostic: MN2PR11MB4382:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +hLsuEytfahDWqFHvbwDCqx3g7neluEF4X8HLNSF8lhwsz3xCO13DvmmuPjFCDJlzyEgpVb6F6ZUfvKEYKt8ehXw/3nhlCdDcpB/3jqBjpioSrMWzc25RnHQqXvxhF254r1/cEufJ7E9gFuTzOewb+Hj2OPdPC7/8gMm6TRMsiMCYt+7vF17F2eA49eZISd18Bi9uIY4IunZYyo6M3X7wwxKgwL8di9tip1XrilialGx1OJBf3urNIz+lJmutK+KtMN+STBwv7lBYo5vRxiossc/ZuElT7t99QqanTu9ehjgtRJcLwsxvbQUqsI/rLHRCnKDGBJ6itGIujM1fv3EfDYYRAYgyWQVuPY7mTbwS7KDHn/brR5WLe29OEE4jUEM+GlbIiySl5TuM/ys30+vASOwcAqRF5XmZnFpw5xrD2CzOf3Kz2tOTgyfeYAlir1qW4HcKMtIsmyfb75X9eBrCqu4Zb/bmlTOjFaZsmDuiiQ7tYCAs/xCsUxtyRaxATHfh1TT41Y1oIm9/qnYuhh0Ci9JBKJnHQH0h9J6F3+wMxFTSjaZd4Q1Z47s7AzlX6FwJsYrHiKrW2gABUBpwYa/q0pf1RY50ZoJ7c5eVjHMuY6DjinHaJMcKrBasUe8xD5bAnZZ5qVqhh9bPkAlW1NrwKKZT+l07Czw3inZNOmH7SkwRJBO6cc/FRD96kBXyUOjE3b0jvVtRv+6yQQNScIOXp2hHDefxFwyGkb/f1S20W3g/vFvmuZ+k33DxEoKxecaleDBrB6rmdc1w76rLT+ljSbmfoqtAES9gHr1LRp5SKk/5wSicOwhTDCmPBI25+gu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(376002)(136003)(39860400002)(76116006)(66476007)(52536014)(110136005)(64756008)(66946007)(55016003)(66446008)(54906003)(66556008)(33656002)(38070700005)(71200400001)(122000001)(316002)(41300700001)(478600001)(2906002)(4326008)(8936002)(8676002)(82960400001)(4744005)(26005)(9686003)(6506007)(86362001)(7696005)(186003)(5660300002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8DzMQoLhYXgaMFrB8XXd1LqvbeLZg8zJXLnB8sT7UQp/Wrhdeqv9euYQLGxV?=
 =?us-ascii?Q?XH4oQfQqB/AGZg+GPXrxRkVliiUTtqbhtL2N5lFt9bjMA1c8wbFs3us466B7?=
 =?us-ascii?Q?2P47ZMdMMbitpwi2u19/WSjUxXSteNbsE3ecBfaEJPCnqJ3M9W+faBjnH4IW?=
 =?us-ascii?Q?ItrLeh0BdurB8NlirDQ9ucpQDNi/IZsMz4K7Hh2dEeUzEI7fR/yFuDCg8W9I?=
 =?us-ascii?Q?6CeiVk6k+6fZpplTTISNuS0JMeSYmaXzmkA7B48/j/cshsmGlwf0tvQ3weL8?=
 =?us-ascii?Q?sXdeb3nuSplpqvd1g6dkEkZ1SMeC1nzY5riqt/VjOsdEeTOEfnhqii+Fvrm0?=
 =?us-ascii?Q?idz7BVHz9sLL/MWoeoytToOdFmPpTHb6C5VUG2FYJw3flNtfSm8o6TXAHRC1?=
 =?us-ascii?Q?AgCMx2r572arr6RMJRzpdpJnL3TE/zkL2fZgGmbK4XMihCQevX9w3bPeYnY9?=
 =?us-ascii?Q?/Ck+te1+BVXXCL6z+0KygDLPDeHUc87VIwS/n+P4+yhzFSTeBdbsaJRgkXZ+?=
 =?us-ascii?Q?r964mxBdlcLR7rCoszlDB2/VGjJgKGTFRpojTTsxwSZhf3E3kwfTpNo58cED?=
 =?us-ascii?Q?ayzpPbB747RetzAcIIAA/iQ81TKUM5lZEqeufUAp2+bdcdEiNQiVnsBtz7Ch?=
 =?us-ascii?Q?ZADBTSiYbFV8thQ5Iv2pwHT+knQ6XYzqM25WA71MsQK+MNP2jc8RrH4QLHNT?=
 =?us-ascii?Q?kgzO5e3dpHRtCcjA9FSN71RCXfj6iPRIfO2BYljPfaUhYa8FRnQor8ZVPyAj?=
 =?us-ascii?Q?vsyKiuxh0W6SGRX6/comWTBGuNCQtoIF2Bzhep+zwldRVQLysu3PCmLsM3sN?=
 =?us-ascii?Q?G8s4kgsauC73ZNZaooxrkboqYPvoMbdfmmLQbfKXknc68bgF+DBnni/gwM5Q?=
 =?us-ascii?Q?2ECUVByaydpjYpVmJalAzMcoyhDFdWHbcgrWbPNmdap5Ol7Tr9gIzV4IK1+z?=
 =?us-ascii?Q?X6nREql3Ivp+RaMggeAPJHaHiZMdl8uOB+nD/H2a/Xem3UFmzyA1cOKTDP6t?=
 =?us-ascii?Q?PNUsgTZCt1Px+f9AterZztMojnzK/L3DXvn1vm7dt6yqOo/WCAxDUa/8kpvb?=
 =?us-ascii?Q?kbXqzMnswuf8yGgchThXeuc3DglgWpd21FWfmX5JoOTCJ87htl20FRtjiZ8x?=
 =?us-ascii?Q?L3Io4cX9MGgJNeI0jvU+TqRGjsTgv9q8fUvksovnK2LF5Jeu0Gq5aGrLfCln?=
 =?us-ascii?Q?yMWXltySvdLcz9vF3Y2wRB5TfoCEfP525hYHoaio7m7q/MRMt+pve5xOVY+U?=
 =?us-ascii?Q?r4MDdzYnE3jSPZ1A2HIFgD8kNdDKdzfIibJYbHNmVrnjG5xONSsZTuQPZtO9?=
 =?us-ascii?Q?wMO+s2N3cvhv9lof2VrWSgaPNYKIydMfB6fTl5/3qi10vV2ckSTFLK6hYe/M?=
 =?us-ascii?Q?FQSiC76UxdzTpsn9wnoJJm7KykSsD6qFxY8Q6hc17xn3BqHDux/VLG8PYP1o?=
 =?us-ascii?Q?rj5fT8fZco79FSLW4yufR1ekgvOCvzXxgb8taQFetZumcGypJkojVar+XoVI?=
 =?us-ascii?Q?dnJc7RoZwHfB4rqDzJ6DyHQ2iYgwbgDetBExjl3SyVlcwtyZ1V/Nf4u5/7Nx?=
 =?us-ascii?Q?hBkOrWzdLXg814lOqY600h8XI5/3MUzshZcg5GSu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ac0648-333c-4c88-5c47-08da74a84311
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 16:58:45.4416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tENzKSfvgAJA5xxcbEDcEepqhmtqdF1YtByYPPZOjNyVTV0C78MJKAO/KwKiQsOw1pFvy62QCcr0+BpNeI/Gig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4382
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> I ask because struct mce is UAPI. But I think this is just for /dev/mcelo=
g,
> and this has been deprecated for a while. So on a related note, should
> /dev/mcelog be removed and struct mce moved out of UAPI? Then changes to
> struct mce won't affect user space, and we can just consider the mce trac=
e
> event when reporting to user space.

Even though deprecated, mcelog still has users, so I don't think it should =
go away
yet.

-Tony
