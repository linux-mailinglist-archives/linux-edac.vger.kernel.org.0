Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B0774052E
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jun 2023 22:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjF0Utc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Jun 2023 16:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF0Utb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Jun 2023 16:49:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E8BED
        for <linux-edac@vger.kernel.org>; Tue, 27 Jun 2023 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687898970; x=1719434970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d5RFV+SU+XDhV+dB+WueBqGX0JF0wvoqrC0xA9LR/QI=;
  b=LJr2e42zdSKQDYtku21P31UJMFAfA7XZd+XYctUa197eD9sh/fQe2gDF
   bjncN3jPnImKpm+jPohbLHNm+/tWkvI9+xDb15X7VvWyk32rptaDA9FN1
   CXnVmPiXAAs1fEsOcCtALYDTkZWNpVB+WLPWXTLK8xrgbIl2t4/fVs7LZ
   6adQDBlF+s+seoF5RQKLal1eDhECKTtO2nRSgPVMzCUUifmGtBm6L7DuC
   qH6fHgkwZvUbNLacHzrrWAFPKMkWH9X5shonnMNJrqF86/S09GWUjTRNa
   mhcJZjC/0HvfzWSsO5FLyGkm8H7wGtRqJVHmA60nKbEZQn4uqcJHzwAzf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392318599"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="392318599"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 13:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="963340823"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="963340823"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2023 13:49:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 13:49:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 13:49:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 13:49:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkYphIVvt1gy6Q2nY3oUok+V0JeEj+n+W3xzpa6rJDlmg4V33wxBCQST1QL7ZnMWf+0C1p3LvAHQKAMidPggu0Pq2G1vQRAYQBqh7jmWsoHtKvVrqsc1IKzOWk7Gnvc6/Qy34AZyAaL9Nl4ufp8ExtE/U09zzzXRgoJumvYtJsEgP5wdCG9qMBre2uXyDB49d9ngpws9sw955ijiNuaVhnOzSIW9thJUY+FytNJkF3PxaI1SlcKTvopEZvVnAR9dPTZ9XowseRRkjrtK+7tNrhWcTz6CcHsV6BHmRiFN5xeEDstRhWuN0zPaHCV7Ad89X4v7fLeur155WnI31/GK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5RFV+SU+XDhV+dB+WueBqGX0JF0wvoqrC0xA9LR/QI=;
 b=cJWRLWlw4RtUUl/QpwZ0l3pI/AC8E9zDfeEnc1+R80HLDoHmlrLomrHzuqEFl6DeDjDxFDcknOEtZ/mUp4hYR6OOz6kQ61MSefbbsQPLrgyCJDfkEgz4BfqukStBKX4GY4DSEpj1AtLEwvBmIH+HGYcfNQx0DFwqm0JCGovISwVPMu1XmAf6xNYDAAqzhE/09fCv+uqj/6Snnl1fbfoXUjQSNDFmMdxxTeSutb3veEnecr0klg2IfQQpctmnZkKeD++LoPORxUs/Xn4WqAa50FHYUUQp8sWKuMYVuKYoEGUQ/LVh34u7MHRnMI80GzXxnYaZ4BzbBLs9OlbZmzC8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB5593.namprd11.prod.outlook.com (2603:10b6:510:e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 20:49:27 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 20:49:27 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "aris@redhat.com" <aris@redhat.com>
Subject: RE: [PATCH v4] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH v4] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZqTb1XiXg3ipBEkeQxsRgGT5Gr6+fHv7w
Date:   Tue, 27 Jun 2023 20:49:27 +0000
Message-ID: <SJ1PR11MB608342F907D1440628B574CEFC27A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230627173612.GZ4090740@cathedrallabs.org>
 <ZJslOOHwZzaDdK4Z@agluck-desk3> <20230627203512.GB4090740@cathedrallabs.org>
In-Reply-To: <20230627203512.GB4090740@cathedrallabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB5593:EE_
x-ms-office365-filtering-correlation-id: 3a8db348-4423-4a6f-f4f1-08db774fff3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ydXplAOb7BVYkl018ErOectwvr89gkfcJTAs6nFvre3RS3SELsnHyC8LydKgrMW1l+uByKE31WTnFsKl1Qsto4XppyzDp+XJ9KYXrsCEflPmsR3DPVDGGJqS4bIK4UiFwLX9c+tHCQH+FN0cUkJqeyHYF6aMkkgqD/4GG4dmXs5RfFM9iFdD8YuBJ+nvBiKuYAdOi8QtcbOnfPtIwELrz4rA42af9U+2rsAcdQu9wiCV7GocSEx/8RDhExGFQQjZCVIr0nlbKaNdSvGeo8Sz1uiW6wbeH1aCwXro0/17IY76cogVh1b9DcPh+uQMBaNJYtq5GLuQ4qcd0agpAx3tcsO9S8c+7vQfxbBDrBeHztilan1JksoOf0eAc+fNqTJ5K6ADzaanEdG0YvcwDybauifL5KF00NwQYynH58ynxsqkczJ9lQfqee0JEIJKetCHqpli/YmmG0ykOWlLEW2TjlA85mAe40/4oWl9uSSEGJDlxl+vFZ1CpH4Sr5UCvu7OdfFojwaDdCCNxq0lUc8Uo9NgZSlcYEW18uc9XqsMxUX52PEGtrkAnjEqOJO2IAA2gTmcqeoIhFcSIYx3Gp2luirP8htl4g4y+VqY08Jrqo60Q0evS5RJae+IzWBLWfr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(38100700002)(122000001)(55016003)(82960400001)(86362001)(38070700005)(6506007)(5660300002)(66476007)(66556008)(66446008)(66946007)(64756008)(9686003)(186003)(26005)(76116006)(6916009)(478600001)(2906002)(54906003)(8676002)(4326008)(316002)(52536014)(8936002)(71200400001)(7696005)(41300700001)(83380400001)(558084003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c/dJ73dbDKhIoUQX+0aubYh1qhHdi2X0xxKXuM8Lb75YaZ3TvAPRpmRLYgtC?=
 =?us-ascii?Q?YhDif/ffmYpjGxFrmlaV6ZVGZfTNb2Mw7Wyfq5fIsGCDwWpVidpbDKBJm88W?=
 =?us-ascii?Q?ZXXQVy3OK71ZaYo51Rsh/thD7EtIHkRJczeuXEPQ/y0TRWUOihppUe7owoDq?=
 =?us-ascii?Q?+CEahVlK6tNn7hGumLve6K3N2uX7T7v0IIeLyFA9M1xR9QHaMaFxDGJkB/gH?=
 =?us-ascii?Q?GrgtDTQkUHjWpsq05pE40cR2J1fFFwC9sJBhn4wFSTe/zmyxvYtvTtBjvxwg?=
 =?us-ascii?Q?2o2taFN5W8M4Wplo4Esdd2PH+kzt3oGAt/I6hQCAro2jdRnq9b0oMN0fpcVs?=
 =?us-ascii?Q?yQw0m8gGc5VHos2Vd5jBH/5BX01zMeDNBYBaocmU32NpGhwM9bszMWAx8XEP?=
 =?us-ascii?Q?32oGcuWNYNqWH7ZM3r39JGMe8lxMWCkpj9GhO3NernrYNgEB42HIChpUg1yY?=
 =?us-ascii?Q?vc83BOlmjH75Z+swcy1WCAFqlNZIojktlynwP+N4S+1/7eZ4Nb5v1obqEylA?=
 =?us-ascii?Q?uHIgBQGkBK2s13Q3nNLJ2wa0haChKAO0jFe04MMHeVZLuqeQgHnMbkyQ5uXI?=
 =?us-ascii?Q?EFWJGNUXovwJgbEVujQOHY8tv/1HcZ5LO7TGMhZDY2igHsMTWMK5B3xKy79m?=
 =?us-ascii?Q?SS5/cM/PuILzYcDvSARgXI7/WemxrFdbMrGiFtcERhMNFq0PG0GRzZOsW2f3?=
 =?us-ascii?Q?ouSk9B1Sh+R1TsV2rJovvHPwGGY9E01+q+oUzb1vQ/Q4vOL7rNYTbI2K+4WP?=
 =?us-ascii?Q?bsInrgmEwacHGFpMBEZcSB3n9LBq4VJEopKK7h+OX8xaq0tD4foX1kCxE5j4?=
 =?us-ascii?Q?Wold0HvUgJvKzqRnXkWQEilAbCJawYcqgtIvEjq63blRg2PXlegE+Q6CnFdA?=
 =?us-ascii?Q?SdnYEYNIreWtiszyyHZ+iC0LZUH4Nj1ehRHLxpYndlOglbL1lbhe2x061t+C?=
 =?us-ascii?Q?BNElStMAmChXBJHJhpHONU2Lg0+o1ilPSdeYwxB40cpy3SbcK98D670IMESS?=
 =?us-ascii?Q?Q1fm1ord/btCoorLJiksT51qfpiisFO5Rk1ueYsi+sjrp3LceT8+bG+amPlc?=
 =?us-ascii?Q?BLIaXi9PNznNUcOZTAKItx18baQ6gdkNO88ECMAQ30nOBt9/XYVKzLA6CdeJ?=
 =?us-ascii?Q?cpJMFUdYWrXCgOP5kURA2UeZwS4JJeAfLSNeSkNdNm8ejaCNBFWxFtBwlnnQ?=
 =?us-ascii?Q?PR03ySJZmYds2GXDSABr7IRBWlUuD4Lk/dcIfW2g8oHPn8hImaq9zN4aXFrE?=
 =?us-ascii?Q?NfA/lNEdj1a4HFdGw+aBOIlrcFMbwLTjUUjG3Lr0LljpuVYieVeXE5RVwBR4?=
 =?us-ascii?Q?XbzEIEzeaigAEYMl5Osy5wYUm/1v+qIpoYGWyn+uNC2BlAQbK0k9WJP6OggP?=
 =?us-ascii?Q?w7A+CrhCHDNuCeDrxVs9b+p7eo4GyJ/+g1pgN8riMWtZO4zacgYYKYVehP08?=
 =?us-ascii?Q?DewGnv2GKwmMlOSiOxkbgxaIXSOVJ8Otd55LepWT7l2O5il8Y9DBKSJQ10pR?=
 =?us-ascii?Q?ivi3AVHwbTlOP/rfuIs+XBTn4pZE+6bdixjbcrbdqpamKl7mYfMYe7n821pE?=
 =?us-ascii?Q?75BRUWQFITGlSJHif0w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8db348-4423-4a6f-f4f1-08db774fff3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 20:49:27.1235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGSyC4QDC4CJ4on8thAVyi+Uvxu9CeYvJwiyfJ8aHt6Ew+Ja8NkSb/b0jqP9M7VAkwGFnq9fSLp7J+vS5tFY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5593
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> v4: get rid of unneeded variable on intel_cmci_poll_unlock() and simplify=
 unserialize_mc_bank_access()

My:

Reviewed-by: Tony Luck <tony.luck@intel.com>

applies to this version too.

-Tony
