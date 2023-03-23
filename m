Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3A06C71A4
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 21:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCWU0Q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 16:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWU0P (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 16:26:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B79D1E9F1;
        Thu, 23 Mar 2023 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679603174; x=1711139174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZY0HacO+iNpkXn6EWyfAF7mECdamcaIwAWzG+BKr9kY=;
  b=mCzi8l6V0ws3akAKv1dQMeaNVlkrg6o0IvEVZAcv3WvUOqVCMLTPVP3w
   ShoZWaTPU17Yn99sBAsAdj7gHKott768sz5mKcfjTFxVrVDgzqsnJlHuM
   Jd6Ev1v8jd/cMZirMFDRA1rordFQP9T7fnEn9b8CVmSMLXDOkNC1QIQSt
   VkOkTZnowFFvgUi3m+CQ3wMdJWSrysqSBQKFW2gWGGVsNC3ILcNp9BEAL
   iMaor16LnbdNO+GMFHJosk44CgTfZHe7gGdNpj5wiFN0O6APG0MggAB0T
   JGl/5fcCFinjCpMFyITb5eu0DbxE05Pqd51GjXKTS73DGaz93vR+0Y/Dv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402195457"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="402195457"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 13:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="659764921"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="659764921"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2023 13:26:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 13:26:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 13:26:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 13:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9xqYFiL0qzoP/xM3fuN7bxJgsdgljygUi+4oDjljkeoA7dllSC/uLLDPpNZq+7ObLV1BolUbIaeG7bzWOeGZTSKuNCSFD0Qs6jrLPMj0lwL1rbNzvFtYfaVnmjzbdfsxabGmI/1k5rRHP2nr14mrwq42xJq43X4YNNGjz/3zsET0mQlFk0Nzi1FlDdKE9fvHE7vzHP4nMmHuxvTUy37sgEQB+HCIGGSfhqBs8TsZngYA6/16GxIip1N6vgovgc8KKDR2b6RroHEfQRve/KTVdm1paibBmJmfoyxG8iCyZgBhWFINFm0z+gyD3YcKpGp8O13huRr/p5rCYq1kYlkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFhCjeb5zfSsUYUBw/SBd5qDS9LHKc5Sb1wEYocqK+Q=;
 b=Tx1RNCk5tU4BqhwqUz+pq21CHGgTEQwqjUh14k5TT9/VgszRWvNP1CcqjN/ANbConYpAQ8OMRXuYIaS/5c5ePedHn7dxsAb4KnLA0Xzg4hGa+0XIueD6dQnhKtvxRdShS481m7fZOpuyjmVA+jhtXVGStTlNkvuf0GIdV1ThBpL+Kv45v/at3yxcIqC5i9wUvpCMNs7KnkJptp5NCuzJWB7lKR/zPccxWZ3iLocTMCgOgHLQJQXsYpOZ88rGJtcMS0NunePN0M2ZCYF3bfSd9nfpeSP+3SiDA+2taTgPN/xQAeyRRoU5K0XdAkJJGruc4oN1bLVI4vQmf8AydsdqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 20:26:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5%7]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 20:26:02 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v3 4/5] x86/mce: Move storm handling to core.
Thread-Topic: [PATCH v3 4/5] x86/mce: Move storm handling to core.
Thread-Index: AQHZWPTgJ4wIXq7BtEGVPo9uGmSDaK8IhfAAgAArnhCAACa0kA==
Date:   Thu, 23 Mar 2023 20:26:02 +0000
Message-ID: <SJ1PR11MB6083D33BC6860AB9FE2A292BFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
 <20230317172042.117201-1-tony.luck@intel.com>
 <20230317172042.117201-5-tony.luck@intel.com>
 <ZBxvyqb5Mnt13341@yaz-khff.amd.com>
 <SJ1PR11MB60835D7F85097FEF454DD74CFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60835D7F85097FEF454DD74CFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6480:EE_
x-ms-office365-filtering-correlation-id: 950f57fc-6041-4e58-e303-08db2bdcd264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HYkb1VcqKk7a+6JQ/hRabeG8wNzi3L+q45/+0HZi8POmUE9S3mRurZDPOCpgaV25ewx741bV6u20hR/x7Z8pkfLGcqiKh7w2OZbs1fDDMn8x8jEAKd5H2sOwfyjCptMYdhn3VLbCXXMXY1ywkk7kOxj/c7/r8YqiQzOXZML8BjakURPMeaFNLp9xjxb2efayWE7si1FV/DnpOPrDeEsMYqJ+oRZRb0K343xlv6FDm7vXkCCeKXvrohWtzB7dptLQd4i5+889nTNB59pYW5sjRNlUTD8PV3QDJWFWMULt8VZk36yj/QeqSUeKT6nju98odRUBb4GnvDl3ButKNICZ3sN8HMk16qj3BwWrxy1Z3LcEre+QOC2MI2DwvUN95jvH4Lq5/bIka7Sj43C2R5MxT1jv+zDBrNYG2/cSkZJYJz7t7zAfpMjK7or0qZpDT8CjOMnaG0MyQO+wvwrxSKusvr67RU/bTKKy8dHTSax3kYA70vy5YepaO9Pf08LhQEtCxyMh+ILgiEzicRkwZ5NBfAjosnYwl+blJh296Q3UivMfq313waiE72wZflpj6CnTEiMsd+t8mcI5r5oLL1ONvhkJ8n9NG7epgiGWZwC++/H1H4GSmwSj7Ugx4TlMycgJrKMCm6oW8+xew62qecm4ZkqkKvETkM4j6cwwx0ZFzd6qyENyace455U0kuIbGwRqotUT94B9uc7hK24jjUjJWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(478600001)(66476007)(64756008)(4326008)(66446008)(76116006)(8676002)(66556008)(66946007)(6916009)(4744005)(52536014)(122000001)(5660300002)(82960400001)(41300700001)(26005)(8936002)(6506007)(2940100002)(186003)(9686003)(316002)(7696005)(54906003)(86362001)(33656002)(71200400001)(55016003)(38100700002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qE7ZwQFJWKqdMEi47UaQRbj/x8NZ7lrNbKM8qRLirMdfChyvq4t3A3DOjbXj?=
 =?us-ascii?Q?7RdjJa0iNVn2cFfRARJTZNlocxy0jIpQzAufHaxrejotyTr2WilwHlev4ebt?=
 =?us-ascii?Q?PyXyVY6GOX/qrj99qCF8Qr0JRNX9Bvcz01rD9tGERU67RaAs4X3O31WPdhAp?=
 =?us-ascii?Q?z1VozuAa7OVuwnevSMMN/P7KzxXIhb9toQ71FqbTKGrSR/088WKWyHXzZFa9?=
 =?us-ascii?Q?gNmAa/DrdWa8gX7uy9a8LBssB4Jpu6ois7zpnqJ5UMW0xLc5BUWTCThjxYB7?=
 =?us-ascii?Q?VxyWRNuc0N3zLOjwYS06r7nyDjAmaiuQEiBeg7hi5FcaE3LJ2KIFbcJdlHJG?=
 =?us-ascii?Q?+q0cd0B0ZcmO4wfwNE8xdNfONRWeEsfKm5mftlrYui7PrTeebg8jT22Ytt4b?=
 =?us-ascii?Q?ysEPAhLcZ58PXw5qKJy3hqEqw7qvznJeQaRaaS9AigN1N4o+wyO2qimKLBEj?=
 =?us-ascii?Q?pecSHb00oJwKcRAm9BVBJ/sczSf1HuIepM25EbUYFXB5lz29AYklxUkfZGIY?=
 =?us-ascii?Q?giInCwW9QLXid/gE0UBTBQX6E5WU9EqI+r+KvNEd6y31yb2JxdHvfU3is5Dx?=
 =?us-ascii?Q?oss9/mrHORW+8SdIUJtiE2UxoGExqmFZTGZNbW3h0qxsgLrLyG/3hKvCCqEL?=
 =?us-ascii?Q?Lgb7a16LwBpiHOGo6sPZyJe4XUO2+yt2I0EgtmB+k+xqhky+6nAVt9zN5cW7?=
 =?us-ascii?Q?uQpD0mZ2H2whDBg8ivob508Wdkjgs5eAlrD5n4LNtcStnjR4HmBPP1jQi94v?=
 =?us-ascii?Q?C5v1/tE94GF6bEDH6n3pHuHy39e1QsEuvwn+A6BefzgQFIdbse46J7N6r9FO?=
 =?us-ascii?Q?XYw2t6OyyGt0LFAgTffBp/qKs3xRR+moLNMXQs2OBRZ7kvRGDsoG16S+hiaR?=
 =?us-ascii?Q?l7E7igajbvl4/Lbp50ULs9LomVhVqXvVqYE1eyoYoiX0JsPFILiiuUgZoWWE?=
 =?us-ascii?Q?k1qPFzLSJh0hNxHWM+V5lEJstMYWFZfVoRYw749nOEOaVzHTySzPBlMEkIep?=
 =?us-ascii?Q?FQrcBUcuZn99xWeRX9Lx9+Nh6jkP62WWR2JT91aUJac4m8/FfVaCOa199JvH?=
 =?us-ascii?Q?3UY1c8kXNY+Bm8+XVghl+6HoLozQ/fQwszbnsO8XpV9dk/hdRsmTxeQgSq9y?=
 =?us-ascii?Q?JmSY/1fMBbAzS2G2TNNU20f5uYs3+6/r5UPdskwwcFgy3JHd93hzFqPymhR+?=
 =?us-ascii?Q?Qq+3KYtqYvY5+r/pa3GNOwtjtCME2qRO31YzEry9F2WjKQH/l349brZDbljL?=
 =?us-ascii?Q?CvqDqtmLOHYyOo50R6TPcRVbizy88mUAKUIsUKj6L5SO5oXhoKqawSHcGGIL?=
 =?us-ascii?Q?uT3AOC3EeMby5YZlPKsJYzyO5VJHpn4jDcjkIWAwfMx4pTq4i424r214w39x?=
 =?us-ascii?Q?0ktLODF9t9jU+Lw2Y4iyh65epal/Nyw9A4DBOjKdXxBpynExldlR2HKxt8G4?=
 =?us-ascii?Q?bdqOwzDLz2yd7ik2IPjRdt+PWK4DfLp8kPNF/2SWPhjJtgUZ8i2egCt4dHad?=
 =?us-ascii?Q?VthUEZykllbg/0jegL7R4A6qTguv/beV+H1kmYyqGd10oO3xdl7TE9KmX+1C?=
 =?us-ascii?Q?9RNBaUKYc/+ukQPs86M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950f57fc-6041-4e58-e303-08db2bdcd264
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 20:26:02.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2X85XX4m9x/fbcZHQmzYmI5lOu2GFUYpYMevrVMPo/e51CHTj5sVa904hGuPJFVMnPrC4IUIbLVR5E9gBKpi8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Yazen,

I folded the fixes for the issues you pointed to in patch 3/5 into the seri=
es and rebased to v6.3-rc3

Resulting tree pushed here:

git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git     try-storm-=
on6-3

Builds, boots, and passes my storm tests here.

How is testing going on the AMD side of this series?

-Tony
