Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6774CF7B
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jul 2023 10:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjGJIIu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Jul 2023 04:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjGJIIs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Jul 2023 04:08:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489DDD;
        Mon, 10 Jul 2023 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688976527; x=1720512527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8E52ZQ+sT15K2jZFElJzAX1G0EjmZVTDV2TUvCEV3X8=;
  b=QIj7blLVHvi0ijV0VvLpqBaLnUZqMe+OV9hWzYqs/PrMycyLu2QdnBeh
   L2k6F16TAb3M/DVRsP80G2xsLrpkAIzfYapMj9hYSUAALAvbvYQTKYpBc
   g0UdTBRl79KDLsDCkYfHkfor1J9Gf4KIM7Qq0LnEK265AMZFgpIko9KcZ
   U2cYJK5HnGyvdsnyduGrka5yPw3LVgcExjOEW4LRGF1+V73/GxJrdsYpH
   OwVwnBYKnYWYEwHZIlF9H3syDLYQU5rSM9nopPDFM4xycltPR8E8UsIM2
   wOdXaI9T0ts6R/T2HhQ/zpzPOBnD+zvwaHSZI233cn0BQcv2uzdgNCNhS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="364319765"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364319765"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="834185648"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834185648"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2023 01:08:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 01:08:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 01:08:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 01:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cps7nxp9pfbKeNYpdjBxFUZWVlKftV1bBKPOWrO4ZZZoiBrUM21KDaxf98KOZO4gQ4zRhQK2zqITN6N6o8g7nDRtFJ4LQrED+ib9LwRYEup3Ukj8JXBU/ulsAn05bYCywThohtx+sPMxBw7k6lJb306E/EDj7NtueH2rbIiSYDKh8Q/0B2mVZxQfoEeZyDkEluS/UJNw4F5RjJS/80GtR1GIxFZhGMgWTBe37l9t7k73eNmQVYQD50T0JGKLvZ/U8uDtGyqrBU2xBqQcmPDvXQlcjK00ZCHj0UL9XstMRigVCD/ZbM2BXTzTctzn0W9XLfl1rkAnm9GM2FMn9h2A1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJRSKNpdCYcZcWD0kwmcMshVk0tH9wy5WKb1OTyRHlE=;
 b=nTdznQRT5GZPnQaiuF6nrLwhVoPSgikAeWraDneJ25Vq5zTZ6KdkXznop1xO/GXTA11+s202ROR0NZK28FaLpExV1fI3DuAvPTGbvjfS6gHs4afS15o4zrZMULr1PTTJPJgSb6tM3MJBgK5ol4I+gdFVsKKFvZ/Bzx3qIbgfxjI5CyYbL3+pcN6gc7lXAO+1dtc8glPqTgxF0N07MFP8ocjMC/x4xFxISvuf2Pn+woWNa12eNaTTHWtfnakmsB1HxoxLWLQ3t8vdTx/VtztxGOO5MmgF3xU9+IyYjGmH3wfeS1QUNZAqOvWChieL89hYX4CeghXdPpkaE3Qfj7ldWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by BN9PR11MB5339.namprd11.prod.outlook.com (2603:10b6:408:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 08:08:37 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 08:08:36 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Koba Ko <koba.ko@canonical.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Topic: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Index: AQHZrfiT8S4St58DWkKECHZaJCTaP6+o1+WAgAG4woCAAE1ggIAAbuuAgAF4OeCAAEDZAIAApV2wgAPwlACAAPbTgIAAG80g
Date:   Mon, 10 Jul 2023 08:08:36 +0000
Message-ID: <CY8PR11MB71347B20D9B8541CA8452BA68930A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
 <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
 <SJ1PR11MB60832C7FFEF98EE33F255B9DFC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CY8PR11MB713495A12DE47EDC3B7C5E20892CA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAJB-X+X_KW=T4WOe2AS3SFFQKjt7VcQRFUCGYFcjipi5-aXdrw@mail.gmail.com>
 <CY8PR11MB71346D8945AAC57D3614CBE2892DA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAJB-X+Xe9H0O=-2o3hL+pz=aGdSRYX+hD0bAxUS11CZDRVZLKg@mail.gmail.com>
 <dbfac4bd-a9e4-403d-86de-c70668f6e676@kadam.mountain>
In-Reply-To: <dbfac4bd-a9e4-403d-86de-c70668f6e676@kadam.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|BN9PR11MB5339:EE_
x-ms-office365-filtering-correlation-id: c7c1bfe9-0e3c-4ee4-b846-08db811cdce9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9z5Ac5JzfnxyEJko+eRf8GTEbVlar5eZiFQYbigwbm7ISKweRKltLmR4PAnN4Cl8kWCAo/qLKDQFYRnOfDSY7g9Z6qmLtrmk1nb58C6sjbYl7+MQuXK0q75TUC00QtVYqi0h2VP35f40WpQ1zGxhpkILCJ7days8C69ml3thR+ZLeSn6sCPCFnonlx64gf45F6U2dICcfQAX7n0+nqTonYAAt/aEFLKCj6IDF/EirpGZdt0u/leNx/lsZBrj6TYqpytNI0q1I5uVLNN+SaRmTfFBNeeETkgcz3pYzqet0a40lUxYFRZm55PmNLYM4wA3O2slYsJPvqRKneGhAZ/9oHAoIBnILJAs7tQZvOt97nKmuWEIxcXLl7iNzkeKRZCWAof/mPHusyYC18hR5KKunz3rAeShoxIMq0f17v7r/lQ+q0eVYFhPr1X7c7ymyyMgY73qjPgDztwmcvEnMSNo9y4oD4piUcrEkQKOoFkkg8zvwZTRFp66LB7rkHUUPEpCJHK/Eqf68QxVDIQbs1G9OM/Wev1LolCH7jKo6bIvkYFTdLALiUYVv83h9ndFChjxmo14VcGtfbs/WjxTf2852BK/Pl/+HSDBZoEhE9buDeI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(86362001)(38100700002)(38070700005)(82960400001)(33656002)(55016003)(71200400001)(7696005)(110136005)(54906003)(76116006)(122000001)(6506007)(26005)(186003)(966005)(9686003)(7416002)(5660300002)(52536014)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(4326008)(64756008)(66446008)(4744005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dVefSSGQkFVf5AQVEGkdIGfXz4kY1MdUIia8wYMU+9yK8fMRcKe8MqNJoZ1A?=
 =?us-ascii?Q?o6Ryb63GCs2JCSQDyHxEothpuRNLmeqETHft1Jw6DJvgri53GmyIqqmq/ImM?=
 =?us-ascii?Q?4Hi0OMUZyZtNWVWk6RKnZP8F5ZaqeXa0F7lRE3QF09T5km/eW4izXu56/ysb?=
 =?us-ascii?Q?HUn4Js5InVfV/ihkkA2lALWXNVWDHq4dOSOplHukBrfJQCNZ+6Hb25r2TSmc?=
 =?us-ascii?Q?NFCVM+RFLl6nG7tEPjcKEBFLa5UzvwSo1eLoLNlLjwPo4zig7DRd3xupHxZz?=
 =?us-ascii?Q?rbvGa4FDRE4LdlYRZzz3frkkushmqtir7y2pEu+n44SSEa90GPrW9knRZtRX?=
 =?us-ascii?Q?MHMhoTzCuaaOhb78TnImWQCIQ6BKRlXHAJ0D+GqJodOh52ADd/xfbaVCxCTj?=
 =?us-ascii?Q?oQyaLckJQJVm6sGV13akYyqp2zS9U8J509uw4Yqd46u3LdlOo/Fj6N/VD2Ya?=
 =?us-ascii?Q?gmH2WgjLMDGcBpI5FQnXXcUYRahL+iGwGjPtMT0aHWYt55fia7jolqW4VgFW?=
 =?us-ascii?Q?sIsd24sxDzQ4gbxQpFl1PrHZC8JV+er186fTxXco+cEVDhBRAVMnd+QO9dcf?=
 =?us-ascii?Q?Nj3Jao0NiKVbWRHdyJTZOGHT/Pw134ygWgcgL8+C/uA6II+4o+7pQBR46bz+?=
 =?us-ascii?Q?gSwlVBwPwhExYfKkdaAu3LI3waCjVMdUUvn0cfV3oRLM3w6WgHi1ivnZEZSu?=
 =?us-ascii?Q?jvQMitfAVEIqjG6m37tvDpw7lC6txP1QO/WjN5jVSBrNjhcLlvtuotftd0j5?=
 =?us-ascii?Q?tTx/m1pFBTYz9KUwEkf6aDQc/B1exnR3MPLijUplgUL1StW5mOM2oiF5Q+qf?=
 =?us-ascii?Q?81IARC8v2v1YSa5KlII129hLTGEhQnjAj9YKeYaZrepfP8JUY2oas48bQSRz?=
 =?us-ascii?Q?xKf/5T3ci0BGLvO1WgADpW2uk2D7N1VI1ANzLvwGp90JrkKjM0YGYpGbSB3Y?=
 =?us-ascii?Q?XJs7mZIBOgOEDQ2WorrClIQVFWTFHGKXSA81jsbfEGNknk0H2dA7GkFXMKWd?=
 =?us-ascii?Q?asHEbvmqctHAth3J3KF7S5XZUjW04Om+BLxzs7Z4E6xP2iKTiprF2Ve1lMhs?=
 =?us-ascii?Q?vhoBdC/0/pXazt2pLYhDq9XDqBuhbfl1R7A6XPmDHSEfmtj+YvhX8I0gSzSy?=
 =?us-ascii?Q?96DW0ssmrzHOn1JlmnC/RCLPIYoMzvfzDGtEk873H5U6uHewyD9NvdNIkl1M?=
 =?us-ascii?Q?C4xB3nvRHep+xc1a6ihLmsm2fkjwfy7Qf4+Eg6omDnMo5TdBAwDGdD0qLgTD?=
 =?us-ascii?Q?F16o4YiCtJH6UhbzMqdlVGH49OGdQThLNXRO/JsBK0dMpeno48wufYLATnb2?=
 =?us-ascii?Q?gGgt68zHsTJeftbjLC1C+lbdsgkiX/b6Igtsf/Ozinh040wyrRJzVyY9i+78?=
 =?us-ascii?Q?Y2B0G5rKOysKui72ywCoUL0uvkSN6FofQ8Badj7RLGaCvWbojaZptt4et6JO?=
 =?us-ascii?Q?fgZtMrz4yxFAo7W8hwUAu1zqgLwjPnDYADW4bsD1JM3YTvq4WdZyGV21PM5+?=
 =?us-ascii?Q?imz6V4mVDCrrO1e9evtXGb2h5wj+QMH9wAPpqwzl4xoDU6VmqUP1vpBHWovg?=
 =?us-ascii?Q?YHRhOVuQhdUirXJ1yu0bslzLHh6BIDh4SVadc6iw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c1bfe9-0e3c-4ee4-b846-08db811cdce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 08:08:36.7929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 446+Q719wittBbsAHaRHVZTIV479uo1m6C20nEEqbSY1Xg34z2qg/TBOfKTcONJH722R/BVDc/ONWDRgCFCw8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> From: Dan Carpenter <dan.carpenter@linaro.org>
> ...
> Subject: Re: [PATCH v2] EDAC/i10nm: shift exponent is negative
>=20
> On Sun, Jul 09, 2023 at 11:42:22PM +0800, Koba Ko wrote:
> > tested-by: koba.ko@canonical.com
>=20
> It's better if you put the tag in the correct format.  There are a bunch =
of tools
> which automatically add tags, but they only work if the tag is in the cor=
rect
> format.

I corrected Koba Ko's "Tested-by" tag and added it to my v2:
https://lore.kernel.org/linux-edac/20230710013232.59712-1-qiuxu.zhuo@intel.=
com/

-Qiuxu
