Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7E68F3AE
	for <lists+linux-edac@lfdr.de>; Wed,  8 Feb 2023 17:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjBHQp5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Feb 2023 11:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjBHQpz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 8 Feb 2023 11:45:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E52685;
        Wed,  8 Feb 2023 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675874747; x=1707410747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IshdeCZWhDvT3csoABRUYwqtaLaVdHhPB5RldONoLPI=;
  b=WNPueXx9W+uRMHWFhMg6ysuqn43KnmbsTE+AC/66CAfafvsn+dlJmy7F
   MEueUf6EKUCG/WkHEpPSQwLuOs+edQ2NwELL/wuN/M6CGemh+Rp4gtWJ1
   1VXZPZxg7q2X6vvJ6Hiivs/ioptMK49AZfZeWLHM9xORIHrwmTPD0VDYU
   NmJwpnp632yogIsxPX3lbxwVCYA6XTd4BZQCeLSTTh73RDnk6gHh7J5V6
   tm7z98zDuZ3sWFfpqQq9egYoB5g5dGnzWpmtBr5AToIk4gE23HOf8Nqjj
   wpnYkqyeyIWGkUHTffPK7IXIYfaJhbnbbZw2OhGmpYYgsuUOHkSyswrqK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317856583"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317856583"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 08:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="699707835"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="699707835"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 08 Feb 2023 08:45:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 08:45:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 08:45:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 08:45:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 08:45:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx6/oW+3vthY5xLjmq0bHcR6oki+fOgbWorNbqtjd32fXVr5tcBbswFRZh2SWLfgv0ErzxBRlflp+RNSR4M0uQib8n1QSg7tsprIW88TI8bziSg76IRHGOquUg9Y/BggFiPMO+iN/ygzlKhc5+C583mcMqizwTHsDb0QpqYtV3e6AXx6Pqgw8KPbKNdEwawMZ96Bkm9+r8ofskXAADfPfb34DOzRYxfaBMnzMvuGJFP6KnPKYfJI/35q88qnaffvTsxetL4lA09f/0hbw9r5s7pN7n+cDnHRc7wp5TD8x5jX9Poxh7bvhNPryHZU4NHqZDG4PF9tPd/kL4Br84tOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IshdeCZWhDvT3csoABRUYwqtaLaVdHhPB5RldONoLPI=;
 b=YveJZ8ep4J5M5rvpC3OJKFdWfszFePTiqppyA5C6YbhTLsXJZ/iNiGF29UgYnJ0W1vpkyaMGn3p/31UpXxG/klc39yOIHLCqlv06mOoneDeyHNsdbmgQhocModOfz7mU1YC8ybFx7agGE94RHDR2sbGB8ROcF5x5EttayxPgWCjhU1P15dwZZVBOhWx4iqLFkyuofEsB0lhojvRDvcxkUQ8BbYLIa/3I4dMwlx8NMs+2hn9cz4xhZ+gIVh99qOHJP8QqH7yPULMwBjeZf6Eq5s3yMncxkWZhb09Q7Fmm1dyyYJM2c1jVJciDXM1G/EDBXOGoenBFdoVBZRyXSFxJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB6292.namprd11.prod.outlook.com (2603:10b6:208:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Wed, 8 Feb
 2023 16:45:43 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 16:45:43 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     "Song, Youquan" <youquan.song@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/i10nm: Add driver decoder for Sapphire Rapids
 server
Thread-Topic: [PATCH 1/1] EDAC/i10nm: Add driver decoder for Sapphire Rapids
 server
Thread-Index: AQHZOchxor50dsPeJUGX5uzs4pOhd67FRc3g
Date:   Wed, 8 Feb 2023 16:45:43 +0000
Message-ID: <SJ1PR11MB6083ECF2B53D6CF390B06BFEFCD89@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230206011423.50559-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20230206011423.50559-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB6292:EE_
x-ms-office365-filtering-correlation-id: 1b8b9923-dfdb-4f48-bf4a-08db09f3eb52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N6jIgOcdbGTrtHaa2nnc3t6Swq5j6psiyFJG/QidfKZuxKS00JGo/NWLpxtIkF2KCj0uuaW973ir8hcYkickcXq4j5RgGBDNWnIXSQmmjasjrkn9IkSZt0pz7Ho9C7XKLUJDnWDD/wCYRrqrdAEICDjz7wnG4SpEVDjuu3SPlzDJGi+GbMME7s0SoioLEr8li0gVwKAz32LJb2qTd4CKQ6NkWNuYQabWMjJa+MOmgGvQdU3nMTqY6pt4MTTWvHP6Sb/nyP4jRqDxoirV3VhBKf6+y146tugzNcp6txBvHUb47husT2bOw64jUkL/PCZ6mtkU7HnWC7svs1P6RdvTgoRBHxselSLZ0wxvQWKF3d8eBEUfhwyM9kieFKgvpYuAfpd+O664IGfcRloYoh6i4WtCgoHMhpX1GLo1TK4tOgYulHyJHw9B0gQZKE1g5f6IcNeIuRvJpfFM+MR7Sm8aR4WpL2OsQK7zMr5KNzk9HXH7d1QfX8DcOil0E0FwXGXUupSRsZirnSng6+KRc3d/xj4qfhi+oBDvOBF0R5ulbVN35kWHpzkGqhL49mhrAUFJuEOA5g+RfX6zFH0QyvhHfd/hoWAobEYOqXkt6L48871gtVrMoijC6HNhDs+0LyH+KhUk56BeaAX1b5Dl+nD5zuqOBcMmabiFQh71lJ5iOOSEGOwhnyR+ihSyR1CYXlnT05/eUDvWehbefB6IEVM4HQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199018)(2906002)(4744005)(52536014)(5660300002)(8936002)(41300700001)(33656002)(64756008)(66476007)(66446008)(66556008)(66946007)(6862004)(76116006)(4326008)(9686003)(316002)(38100700002)(86362001)(55016003)(186003)(71200400001)(6636002)(6506007)(54906003)(8676002)(38070700005)(26005)(478600001)(7696005)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3P8Hj7Ob2DIirAoS004QkESekx7N7zrotLRDzRYvOcU+KCheph6+50WT/V+u?=
 =?us-ascii?Q?RcnPnrMyU92W37s2GGN3qVtXJfj8A44MtiDueTkmtIqNnb+4LmrI4ZFYFWpw?=
 =?us-ascii?Q?dQd6bdZd07lbiL2QXKWJs/BCBundDcDCUqWIJv8g5PdZK0xFjHgAn5/QvNyr?=
 =?us-ascii?Q?7y6vhf9PJIS2gErr8IrHvmcyBNxqqEBnJK0p/o2X1EYzm7lwMIeLcR3PxPg3?=
 =?us-ascii?Q?4YUPL1B3f5Fiaoga+DN2Vb0DkiSfafFfyzlBa/jRsjDWM/FodybFYNig/urP?=
 =?us-ascii?Q?XxptBvvWuzi8R+Z0QcduBQkxVtICcFT4M2OBmwvSQZqynm3PrYBpN2ZLXGbZ?=
 =?us-ascii?Q?tJ6W3SepVmxpRw5I1QwVmCnioTYxTdAQMvRiIKeug2sI2ZRglbMZlhxPJj7f?=
 =?us-ascii?Q?6ivCXO7e+uwAQB1q/RTK63KJy7A6mw1e+oSrQ88DGKgmVoP/IzAPe3hqL9zD?=
 =?us-ascii?Q?JOMiv83Dj6i8pWoFx3vmbj0gSUFcjLtTp8uxYxHcTSQQxH7AHpjovtSPxvI0?=
 =?us-ascii?Q?+SjHYtMbGioY1S3tSgzCsjhZFMDZ7i4QYdZS3b0opWPuKMFZidm/enuPmOfC?=
 =?us-ascii?Q?ditphOubDFYKhlqThlauulwsD08ClTZqP9ADSpQ85BNTLIcdeWVDalHg+TEr?=
 =?us-ascii?Q?ONOgtO1A/In+4yS+NW+gnHMNqUo/i0n7wKiO81VxRZv6Yt+Dwt6q8eW0/exj?=
 =?us-ascii?Q?AlweOVBlzFZv4xyHRfJWHySJWUXRhhfRpKELbND7n/TOMol2V8k8xjlJzcm2?=
 =?us-ascii?Q?+EFR6zu6W87yJVXN7fWWq9QXUQ5nNDtmAXRlYMyTWnaNWDUROK8v/VC193xW?=
 =?us-ascii?Q?piuSjAgMl0Aoqm7LDKwzQP7QHOar9dqi3njZKao1/n41kIPAEUeSYXNqL+r+?=
 =?us-ascii?Q?jPTENLXEmu+95D7WNffdPGQNY94hsGaYPS7xwElGWO5cFp6NFN6VqddEq/iV?=
 =?us-ascii?Q?uUuoD7pWsDzAJUtqxPKQmcIXsmvQ0Qj6DDtiGOCtYlPXDAVs1sxFtB58fDF8?=
 =?us-ascii?Q?iu5SHCmsSdAQkoH2U1phqJoEQA5g6ElPCHK29WlpeuZNn808wyIsKiVQI7Fe?=
 =?us-ascii?Q?EuDgfAB8wGHaQ2kK/gtbNwotKPn6ERVzccCZmSaJvdaBKk1q7I3B7z3UCYem?=
 =?us-ascii?Q?Dg7QcTOiRslNarAT8ZpXFvcexEZQlZIwy8URpYiOA181t2mVKyqrYi0HhnlJ?=
 =?us-ascii?Q?izPoscRC6Ta/tbDrNN+r0aceY71u2L4w5lp/WKWS6fgQyJZ8uy6RzIU61vwR?=
 =?us-ascii?Q?letTIzqXCeNrlG9OE7m31Be7MN1e0EuBwIenpNObzt5Md49ZCY0nk7cMUde2?=
 =?us-ascii?Q?bf7J4BiCLdYjRDLnM7Rly+dtd1ZK3wWMPlYMgdoNfAkDyGS2tw1jBiJsymyT?=
 =?us-ascii?Q?+XedbgYP3tBsgXSdusnALQl5tk+HilzorTEa7PYIbasNFeyPHMckuAzL186v?=
 =?us-ascii?Q?omjMIr2pm139RVYw4f9LNSRh3FpdHBO/U0fZHNMPG3EH0IawrDOlHCy+oB8x?=
 =?us-ascii?Q?+ihmHtQ6DepR/HA5suHv0SoGOOGC52IrdqfU/dMFbT67sD3Z2BcYxY1dkla2?=
 =?us-ascii?Q?00HlgLVgoWkHHXuP9vHBC6qRvzrv1ccIVi+kapZi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8b9923-dfdb-4f48-bf4a-08db09f3eb52
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 16:45:43.2203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqcpp4Zun/ZHr8chuc1X8e73aIxfw3ADceRUidhpDeqAUWMzkAWuBIITmqvAvQAcgAMVX3OAqiSyX98agF9Ztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Intel SDM (December 2022) vol3B 17.13.2 contains IMC MC error codes
> for Sapphire Rapids. Current i10nm_edac only supports firmware decoder
> (ACPI DSM methods) for Sapphire Rapids. So add the driver decoder
> (decoding DDR memory errors via extracting error information from the
> IMC MC error codes) for Sapphire Rapids for better decoding performance.

Applied to RAS tree. Thanks.

-Tony
