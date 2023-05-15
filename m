Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93222703EB7
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 22:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjEOUlK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbjEOUlJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 16:41:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BC64C3A
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684183264; x=1715719264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FUrFyht3U2eo88NhDj6YXjUMqrU1KyDUFwIqPXXHQkY=;
  b=DPf8PlN1s+GTg+p+1FrXKDu5V60R3zjlZH+9YMTumc78KPATLRpgXPes
   K/Eoh3w72rlmZoO1OS3P67tfktx8oCxMaEMG5bTcEBhtvlbp0OvEiqozm
   396GRG1FLmUajT224LUZ7q7P7WPi7xMEPvGq5c4jiG2MyqIxshJWNKe0H
   9dNR6kZxn2HCMzjsMdf5pmjZRW9wFWoCoPPEXEh/SYRn07EzNOO/IjJ5h
   AnBHNytIpE3VK8tAghSJsw0Gsm6btuh62Z6/WEuRfHBPTiF0JbmzG398R
   69hecVP9z/0t3BXmkssizuKQQ6oBPsLK5hDMaI4CVi1bOVx1It2lshi6o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="379473835"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="379473835"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 13:41:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="790798228"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="790798228"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2023 13:41:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 13:41:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 13:41:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 13:41:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 13:41:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd97u8Lk0aJzH5UiqpXjXcJOukX7GzNUPmoQlTi70dVVpy/0DHoSfmxb+t29B5CNS2jHICNXeq38mPgGtv5oSN8zrSgnR6Jg1H12iuCJ9NphX3ui83AA0uP+IiM5Vj/QUitGjmnrbQWCAvWBUZjvTQJbQdjr8MB/ZaK1g5BQIHfmMd6uFwzC5F9uKqOkLEI/VaX5DePXCWCqKtIfmJm/HRdZaaae9CHNzIG6OSBMwtytyF34poKIc+Va1SevUZ3zDr6dpuSHAdcsn/NcsNNd6+LZTVdRQ5qwh7ZXK3txp/JJNNypkXFXcwF82XDMCiVNB9qbpMmzhiGpr7H9yMUaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUrFyht3U2eo88NhDj6YXjUMqrU1KyDUFwIqPXXHQkY=;
 b=E61XdFNcRjQ0rKA3YI9kZfzUmGHbHf2Grpw5Jj1lw4sDy0V4Iv/IbK222gPN5RUKXWE9O7my5snErnnNzf6NC5p83Gdq7wUSq1hW2FnvRz3j5DcpvThVX3rpXsJx6n0gHg3t9y9cqkYq6cVifWx+mOiHFMkZIcQqTOUVV+IafMc3FkpYs+kgxgZMV+CAt5nhgbajm7v9YY1BWARvljMCdAYpEqUUeIcTmMLdQRABBY3ZaEHhqHoZRHGj44YAu8J4ZY+VYTvkPSqEgpCPfcoDW1ergSfhyr2o0mIEnX3K+z1UMU/9Wz+N/kBBDAL66IvodYfYsID+6XoRQvkz/n94Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6970.namprd11.prod.outlook.com (2603:10b6:806:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:40:58 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Mon, 15 May 2023
 20:40:58 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7CAABk1AIAACA9ggAAMfoCAAALmcIAAB1GAgAABc3CAAAG8AIAAAMRQ
Date:   Mon, 15 May 2023 20:40:57 +0000
Message-ID: <SJ1PR11MB608351C9E984168ED17CE8B0FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515202057.GD4090740@cathedrallabs.org>
 <SJ1PR11MB6083A169CC5FD7057338027AFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515203220.GE4090740@cathedrallabs.org>
In-Reply-To: <20230515203220.GE4090740@cathedrallabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6970:EE_
x-ms-office365-filtering-correlation-id: b788136e-c5dc-4fa9-3d32-08db5584afbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBgveTq/Z2nlLHdf+OLhk5xPJIFReszIlO7BecTODsnTp/lEs/srb3eAZ8/K+71gwYjrnh6v+RRgP7700JAegqMaKkXGu/z9mi7b3CX0CRnToiDuqMKLkmBL8lueCWeiIob8jGgfmbAWRsW6lzMCBtRgmjTP+7jyBvraeihVVCkxaKLUaXl95M+3x6S2rLpeOGy6czXaFkSuQKxze1qKBz5o1xcT52o3YO+QWqNbeBJe8XMw0wIkHSfvl6/T0OffFxeHwAAjvyJq+aMhUpcEqlb0oNMOvjNqXL74R/HvGdG/W681AkvTy3BEQB5VTKXro+84VKZQ5g882dpXaJRy1ipFNcM+BdHpe/CEu6gnXN7t03arc/eC7gXM5nA0/RyMubem3U1fTkLWCK7SRzmpRNxq5x/vGANKj1Cev8TQr9X3wCcbTrAHmjZgz3M9T8R9NCjuO1faxKIHo5UOsX56nzJEpDVCb8DPpFhvgTVu9zJFECrM7EkunEFqtM2n9SJh1phUrTphnlYdFO8KJ/3eqF5d8FdCNcDo9u3erikrIqRQDJE0qfs5crKjeDnre2svUaTjON7Y7mYbOaTwOvkB8bvII9PEozggsdHj7atJlyVSTmNfa74PCu1ib0/2nY2d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(33656002)(86362001)(54906003)(316002)(66946007)(66476007)(66556008)(478600001)(6916009)(66446008)(4326008)(64756008)(76116006)(7696005)(4744005)(55016003)(5660300002)(8676002)(52536014)(8936002)(2906002)(38070700005)(38100700002)(82960400001)(122000001)(41300700001)(186003)(26005)(9686003)(6506007)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O3K6wdSiyEwv2W60xqWtXrb2khJR4ng/3YB3h957M/MKLiELqw9D3nNGv/SD?=
 =?us-ascii?Q?emgZnBV2AcFQOYrKwnuWDWczCswuLV3Bjn09OPDivXTEvg3IV6jHN0YDGAOw?=
 =?us-ascii?Q?rO2vf1PvVUU6IywI1iXwiEkclb9c6UDBGSZ/j85HgWKDEARPaUM9/j+u3qJ1?=
 =?us-ascii?Q?kPfDvfFuTp1M+8bJuBQ+6EyqjiAjMCkoALROUXSynhkIQzHobdG2pxUnZoZg?=
 =?us-ascii?Q?KtlCpcLyJw75Ul0Tbxi5ya4rjb9slCEiwSNm7alsUYtnWmgP1ZCz4N6CGTkz?=
 =?us-ascii?Q?uSc8HofkzMxMHMRK062I7aLMFMnbBzmSBeqqQRu4qy5TyL9PYGUPGLkyiBse?=
 =?us-ascii?Q?nOfXRFLrSDAddPCrJ8dbk2pV0ktr11mvzG1q7EIiwUdFAp2tHXx3ZAxfgU4F?=
 =?us-ascii?Q?U8fWgoHSa3pR72RKDL8T9y9DBt5DE1kJBFnBBvu62zIUgoWsgc4bAjcpqrYV?=
 =?us-ascii?Q?OK0DsF4IubMOtY3BiYFgiCaXhXz+RzisARtTECq1/b7Gx5ir1bnDdhtPtx7i?=
 =?us-ascii?Q?wBbC+3ij2QmwakNJGb7M6Cc14BRjQ3Lq4SEvLiYw0mnptdPySluNnRTjh+FG?=
 =?us-ascii?Q?fcoe1rlEb4eG5UmJ5s0fMoe1/1srmr3tmDdgGeCxQehXymUT1brzU5e9UJvP?=
 =?us-ascii?Q?AcnIbkxudxEJL0g3UgDrjnHeuXbcQnnHGxw0ty5fzS5vchV+9kUadTlpNYBa?=
 =?us-ascii?Q?NkO2Vd6TEkvECIAdc0F62VsupN1suZJ+uoPuZ43F87D88WDuPO2jfXiBs2CL?=
 =?us-ascii?Q?dOIRR/zCC2wMnajVZcKB5KLK4LCOd1cNxVQo3uwKbCNOGb41EPWlhYhmmi5a?=
 =?us-ascii?Q?EE6RN5pCMIxByrtKu5s7XTVXkPN0TO4EcuyZTDsoYIXYdEmcleTvbvbySjPN?=
 =?us-ascii?Q?DwwkiaiQPDyoLf3OaRurAQRdec3ndVpDJEEdnNkuMKA71aGFqFF7g2qSH103?=
 =?us-ascii?Q?rWTpZD1bil4tMLLioX/0Zb+NvKXoGcGWFXZiMEuN2n9EtuHy7nsZdGLC7uFg?=
 =?us-ascii?Q?lUhiBVmm3QmpVxW4tnulIjgoWp5zWY7IKieMvkiRAU0iPvZqjDCZWA2dd69w?=
 =?us-ascii?Q?zZKThwpqhKvxHOscxaKX3Dv3gkvj5tGzD/PUZMGpnp4L6ixT55hMMqkc0oQM?=
 =?us-ascii?Q?vP/mQgpmRzSzUSBvjJYm09J19rh3InW/FbI2ta1dvoy2BiCUfpudGWQ4UjJH?=
 =?us-ascii?Q?Gbkmg98415ynmJypG+5K7tSRRiGZSavpJi40PWkmx4a3uFAdlq65o1CIcacN?=
 =?us-ascii?Q?tL9on13tOjb2ohkZ8prv9XEMqPdRLaqgb+w0HZdxMvarGHiwoP4lbWk2hHYZ?=
 =?us-ascii?Q?2qFtW7byt18rji/U9Fzz4h/J+ACrMhfDLMA6xdmN+kSvrNMlNvnTKfPOoB1A?=
 =?us-ascii?Q?SvDt8YWAC+2MwU71wE9+G8fXq0pCqjF/bUT/G8BkjviX/0LB+8oSEw4CaD/m?=
 =?us-ascii?Q?39lgf8fTdZXMyvsEyayx3VsUOvtivPtf3dKoxDzzDsOAsGpwLGz9ij2ClUq8?=
 =?us-ascii?Q?S2e+bNZpcPEpxxYC5l83L6CUOKfFbRrdrUD/xNrV2T5seGdHt30hBRX62c0k?=
 =?us-ascii?Q?G9e+RhsdbOm9Wwpxsj8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b788136e-c5dc-4fa9-3d32-08db5584afbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:40:57.5317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVtMt2xCX7vIfC+NhqkVf5+8pXkIjPcH8+0E3i+6hiOcDphbHJgjkKe3cenL/RrlucbgtoM4puis5sP0yrLgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6970
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Now on the CMCI storm mitigation, wouldn't a system that got a storm be
> subject to this same issue of duplicated events since it switches to poll=
ing?

Current code switches to polling. But I think that it makes use of the bank=
 ownership
information that it derived when CMCI was originally enabled. It wouldn't s=
urprise me
if things go wrong if you mix in CPU hotplug with a storm and offline the C=
PU that
"owns" a bank. Perhaps the ownership will get passed to another CPU in the =
same
scope. But I'm not sure.

Those new patches don't switch to polling. They just reset the threshold in=
 MCi_CTL2
to a very big value to throttle the number of interrupts for corrected erro=
rs, while still
processing the UCNA errors that are also signaled using CMCI right away.

-Tony
