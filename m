Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC13F700F3E
	for <lists+linux-edac@lfdr.de>; Fri, 12 May 2023 21:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbjELTTm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 May 2023 15:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbjELTTl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 May 2023 15:19:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6597A97
        for <linux-edac@vger.kernel.org>; Fri, 12 May 2023 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683919175; x=1715455175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NNeU0kNdhZUTVHYZisw5ILjdjqKsexccjvplbKt1bug=;
  b=J5a6AQecfaxOdck/oeT5zJ1ePXzBHsXLv2tSlReEVhOcWAOqc+RqxbvF
   rT2Ihg+FFAo+OQR8sjCOLzh6yUqRlOpQs7YS/KgaQp5/FsFte8KcrtQd/
   MhIAe/AF7FyiAoyuHzCBan0Urow505jFrHvcoqzNQaNDHXwWtZE1bcRPd
   isaOfQJvnSJRUlABMdSteA7b2nT+K1Od6fN8P8YyDEBoZtndAJVZg2Mpy
   zTCUC9MlmbD/+lbEqDRHMqzO//W7jG5XtvPPC48Xe7MONoBvJ3QF0yHbt
   A8dm9Iqkd25nxTygCY4lNjGgeSNZRkJgotUr3OQkO9kiSFeJ52d1//qKZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="414245485"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="414245485"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 12:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="765265841"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="765265841"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 12 May 2023 12:19:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 12:19:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 12:19:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 12:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhvEuyXhRhew618YA48uS4/pb3qlOz2f/xbJsLMh9c2pTSC7dwI2CgpoMfcckbJ3h1w8nWriYTNPaGp39fY5giqKAyKDSCOlgUW7/FH+vGv4Pto2FTr0xS3aVOKojKDP8ER9uSBQXJ6xhrRWjwAmULtax+iyHSKQFPT2vUQ1Egm95MEAYsbtTI3NXO3gO8/UxLTMFRozm4FZbDn0Frz1H2i1kW0SWn+G65Xqc5UzVQ2Q/fyqZUHVaOX4EN7kSVMaxbhI7t/DAwBu50vQ0r7GN7HFE8phyOWjt+oyGBzyv/RdKh4+Yj1ZVOByY4Kpv9MPXTNuaJE4rYtEEpp6JjPyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNeU0kNdhZUTVHYZisw5ILjdjqKsexccjvplbKt1bug=;
 b=anFvHOWHqOjZBUwcEHTxnwDUn9ya2lUfJGerrlzRNmZp9iLUefNQptBF+HWNU3Vq/MVbPG5taCq1uHB0B9drrpdF4nw34f6AzJ7sY2r7fe9aURrG761JTz4HAtxelKy0bpfMNXBVZjn3q7Tu+VVIxNQULd9qLRofHCCyZCmBo/ao1mFPzHS0+kfdZ1JRkZGOlByHDozuOrGgqrLWP+snsMzFVmctifv+IJUCJ78D9+F91fRBFsmUlUUNKH8ZblAJwrJlssLCCWfDyg97nFCQ+8QBDTtAP4TQkAfpr+7m51ic2KTln8AQbTYjq9KHwjdATLrR5oILcljSCG2DfQwLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL3PR11MB5684.namprd11.prod.outlook.com (2603:10b6:208:33f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 19:19:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 19:19:30 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: RE: [RFC PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [RFC PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZKeVgS+RUxFZo/k2Cv7a8Veq3q66i4AIggJ6eqgCAAA3xwIAWD36xgAAdGrA=
Date:   Fri, 12 May 2023 19:19:29 +0000
Message-ID: <SJ1PR11MB6083EC9DB13B117E99595DD7FC759@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <Y8WtE7BNJ0gTrqIS@cathedrallabs.org>
 <SJ1PR11MB6083410C8464DEC926C0BDB9FCC69@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230428155102.GE2449174@cathedrallabs.org>
 <SJ1PR11MB6083083A8C72CAC6E39DF924FC6B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZF18kdWCWKqFc23p@agluck-desk3.sc.intel.com>
 <20230512173251.GB4090740@cathedrallabs.org>
In-Reply-To: <20230512173251.GB4090740@cathedrallabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL3PR11MB5684:EE_
x-ms-office365-filtering-correlation-id: 88e3ee42-cdd6-43c3-2eea-08db531dcf57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iN6QO0dJwt4a455qSToWYU71OUofu8jX3kBd0sG8I0KP7WVPZKM0kjVp48Top2B7dfbkrNLr4WimD/7Lhtz13srbCZgfYobBeAAkuV4UluTzVotFDI4ynDC23m53uTVeAPTNEFmWK25ryWAADqTA4Nh9pBHwNQVd2D1FD/tf6y7GGr8KqnkhypmXjx9S2tjW8Qt9g2ON+2r/DHPRTfa3EOGCpWRuK77eMErgHgCd4MfRCf9yCIr1RZgRS1wOuG6EXBiEb+kK8GumwWWPSFOaKejGI62211O9B5ZT0pKuwe5XSETiO27d3hGDYt3zpLE7kWDzZDFnhfP6l0BAX+NE0QKQWUMjkx+xnCPPshIryYwkDnVPmEXxcTqO1nLjFRyj/ZnwE9q9S2UAyGBu7LCjorkMq3qZiq9VTSz/Ccg1N6UJkbYC1w/Ir4U4dfLqJwjQ72bJPvU9Oaj0a7TKPeh+316N8DI69BkCue/gpm7UTE8rgupvMjM0DHtCNpCcZlvFLbUVhooc/H5mjtoZWysnta6MME1mAaLFydfJjOLltANnViJb2vikuSjU0TbbmH6cv7p6CjKG7wG/NbaNrCK+OsAcWYHfOczBe5lPvMMIVYua4Ae+0xtQW04CDAcHc61w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(7696005)(66446008)(38070700005)(54906003)(316002)(41300700001)(71200400001)(478600001)(86362001)(6916009)(64756008)(66556008)(66476007)(66946007)(76116006)(6506007)(26005)(186003)(55016003)(82960400001)(38100700002)(122000001)(9686003)(52536014)(5660300002)(8936002)(8676002)(2906002)(33656002)(4326008)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sQ+7U+zlHhtMNKXbEP4IhlTKotyvhzkWeQsd8ShNM3gSCHoeoqmBRYdWVqUy?=
 =?us-ascii?Q?yt0pTQtmigeyv5JCQeH/tNMkXWfF/ZTn0rk/aTZAhMB5+L/qQl5He46nQTYe?=
 =?us-ascii?Q?tJ7wqYMNhLWVd/qcf5qsx1q38jYcB+h6uk7+vB/CaX59dsG36JmmSSJP40+E?=
 =?us-ascii?Q?Ji78WVt/Myf+onUCIwZZU12N8dOE8BtO5ZEZpFirJHkzHc0dUP6MGdidb8LM?=
 =?us-ascii?Q?ZV8JavL64xCm5kDKs0zU8AlS0mEcDByiyRv0P07YhPdR6bxAh8HwIcqv9hvO?=
 =?us-ascii?Q?/F23i6TpLe25Ep5bt6SE/UbED4D5Lu5RRNA30RHzzztpZnjdmozwqoWtETpX?=
 =?us-ascii?Q?WqNXTrJOKItZXt30Oe8xjPke04enqSxFVxbauI+NynRA8NidqiPXHNfkgYcE?=
 =?us-ascii?Q?bbn+0iBA8+hy7wTGLbxlLY/4LQQ4u/QbvATatvberR6uXE6DFXVyW/HnV2YM?=
 =?us-ascii?Q?y87rH2wuVeFOeCXn4I9h9O2FsRP0nF6W9V8rBy//0H2lB40I8rhDf2wa1D+Z?=
 =?us-ascii?Q?kzvkEMQbj5qBSnhVAUcC6Cr2BZq2EKqHYY3kHo5f47FiLtS2dk1WfeH1ciJK?=
 =?us-ascii?Q?q13BBQAEr4rLNRpEpOHeCan6hs5sBcSCcggS3IDfRLMtwKFCp6f/8RecfP4Y?=
 =?us-ascii?Q?OEpIF+Cffb/ojatOG+CSPJmIVV6MOaLjf/9+Xktg5r1pEF4u0ZhPaIT3+vYB?=
 =?us-ascii?Q?66Q0h5eotn/QgNJkGFgezOtpBUtitvjed0SS4z/pPpdT4bXBaPeyezGO+7d6?=
 =?us-ascii?Q?+W2Wovohn0ymOzFYfGpsNXL2dqklJWA6VBT8nSYWiWtlZBWR918U9TY9gi/S?=
 =?us-ascii?Q?GPjywXXyctgUjb5ZnTuwW3ZU+bVHx5PDjYoo4XgQAmskQrOL8TBsPNyX2wr1?=
 =?us-ascii?Q?5tpTQRyfGIm/SqtHSSfIRJtoNiwaf4XSAPs5pn5tj87wg582hrnbXbanlyNB?=
 =?us-ascii?Q?tyjKy+1h4ja4qS7MXstpfKf5+Kv2M7P2WoTxQ3rVlkMN1tNvR68wjEVrBgCT?=
 =?us-ascii?Q?c50GcK23ffKNqQ1EN7IY548lDeDdWE65Qi8VZLYT6YTcXtvbGEOuB27v53Kv?=
 =?us-ascii?Q?fSfFnR8ckGbavTIP0xRbp8D3D/qRUNekDkEmD9Bv+GkkqSFq4cBLbm1iNndy?=
 =?us-ascii?Q?6/FWZJZPQ6jJXu/3J9k/xIx6IXRYD7AgIijANHggNUBJ9d0sO5EEyAMlFvHE?=
 =?us-ascii?Q?iQSQ0vcKS2scvHhCQfi3KtvEE5hag0TW0GBUbFsPX/onkf6cQ8Ze6PxS5CSe?=
 =?us-ascii?Q?S71nrUvVsvzyhdCWWaGMK6ILJ0HN34qC7aT0dqqGR2SwVz0H3NdPYFP+PDjc?=
 =?us-ascii?Q?qCQV9Ww9vtcJP2PS64UX1gFJwY+8JZvoqWwlE1JsDiaepwg+ftxFsdBsKZXg?=
 =?us-ascii?Q?8VzBjPabY6WTLG4ozDhRSjbNe0SqA+EP0TGo7wWk/oRMUZ07YvvlABeaSxAb?=
 =?us-ascii?Q?8y8Iqp1Ghu2GIF1kkye3xAaNbwKNJYuKnM4JHbKvQROFxGD9G5UnQ96UFdHU?=
 =?us-ascii?Q?BiohgsGF/7W5SMQxe8kEVcjMcrU/zaAfkb4m/HdnJWm8xBdzDEs95DavIGeM?=
 =?us-ascii?Q?MqIQhLg0IZloN7A8Y9M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e3ee42-cdd6-43c3-2eea-08db531dcf57
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 19:19:30.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lt5rh0vjJisfht7TYJqfKkgdOxevhDDImRDCoSTREnQYe5s65v5jvXdXIm+J1flYc5x++ppSY+jHNaNpEzi5hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5684
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Thanks Tony. You want me to resend it or the original is enough?

The original was marked RFC. So send a new version without the RFC tag.

You can include:

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony
