Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B863B0AD
	for <lists+linux-edac@lfdr.de>; Mon, 28 Nov 2022 19:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiK1SDo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Nov 2022 13:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiK1SDZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Nov 2022 13:03:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EFA4AF1C
        for <linux-edac@vger.kernel.org>; Mon, 28 Nov 2022 09:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669657785; x=1701193785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zcz9YwczYc/ZMVOrdutwTGChuya8onxxdOWPv9Hw7Ak=;
  b=We5OoScETnBh9Xz8dTIspFv7N+6PSv3zGtSV2Vu+9NjDOM1QOyOozxgR
   0hw1lbGdk7yRX3fvZYXkxvNoWvH00WZFI6PsxXYLA+iOG0AFEvSqaNF73
   Rya4y3aF8UAEEP4bYtICyuoSPnkJV5GsikY2qKAWyqW03FVTrURUFr7Zs
   OD4EeCJr/BeWeJ50Z4hR/dxIwg8gNuD7kf7KidBwAaPY6/36GuilrxLXb
   d6eziZPTqiYMiuiLEEXY7dXZbLaFWzqPeRLebNYBoMGxskEOLo6t91LQU
   iZ1nz/MpfTcab1ZRNji04/iz1IWBNFLINJd8nFGrA2C3fb/dcJyr6v4PU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="377049200"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="377049200"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:49:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="643477367"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="643477367"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 09:49:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 09:49:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 09:49:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 09:49:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 09:48:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvmovW6bX9onC+sn6th/nSHtOUsKcXE6zvzxvXqAG8h8gu34WcdgO6lHl4RTXo2ShqHeErh2oUExm6SIzEwoYW5UjgwGSDREfH+VKnwXjCntCgGeqZ1fTmWBJZ/9vmsL9kx+a/hMdkexxphpTiz8pjJjovdXNnLl3B+ZBlGG0ZOJDt1Zm2K+NHyAIqoOj2eA0YECiyOk8gsNodqhafRHgNZeRJucW5Lt6Bu/bwjl9OErllrrSuezl7Y/v6v7AJEl9wL6LcGVXtWNN6jU+SVGhvZPBizIJ1W3I/EYv2i+qVj9MPLeoH3pHG090R65ZaudF9aK7Ri1Kz/Og+K7RJjLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtsZqFmLkucZ/EQAPn0uEPcEv/Mz+78qJso31DrnV3Y=;
 b=HKNvjjHfGu528vGCdI6jXvb7SkgUWkk4RSvukAgXeOx/Y+SyzeRyd8MuLH75e77a4v5/oGHIOwIz6gpOG6+Hhy9XP4ikdC6L7aC4sqdFzeQrneMuuJLLqEbd4Qi5sYWySchPBrZ3OCTPKeAaIAK4JlZWwxAtWn7A1MuXDuH53gs9fyNlhW7ibt/xVOAtpl4XGjkJWRkemORrNn2xODTKwf9LlafZ+bMj1s4YnqjdipWjPO5yGe5eiKCNRXM+7DyU2iwrBpvIkgoWmiZ0qWUpIJ0vZZcFkVFj7j9msjF7MvzEVdC2VnKmnjtljPdfElclpjJ2unnoNpDu1Yawk6+Osw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 17:48:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%6]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 17:48:50 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Subject: RE: [PATCH v2] EDAC/i10nm: fix refcount leak in pci_get_dev_wrapper()
Thread-Topic: [PATCH v2] EDAC/i10nm: fix refcount leak in
 pci_get_dev_wrapper()
Thread-Index: AQHZAvaw3IcQhiglZEu4VYHYKuOqNa5UnMeQ
Date:   Mon, 28 Nov 2022 17:48:50 +0000
Message-ID: <SJ1PR11MB60832E184FBC6204DE4CF71EFC139@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221128065512.3572550-1-yangyingliang@huawei.com>
In-Reply-To: <20221128065512.3572550-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7696:EE_
x-ms-office365-filtering-correlation-id: aecdd443-49ab-4dfa-f8e5-08dad168cf11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0I/j05t2wkvG2mqZhZLX0QIRJxdUHudZE9qILnDwfgLsLQ5BLAoOeFgMFtERNyObSW8h2SOSyWsQzQ1CP2WIk7Pw8pXz42Eg/zlJtfaFlBd+pBbua41a0sID+rWlpurl2LIHhZf7b4SsE4RrNOIZX5N8Xsa3Ni9wGGQEjzwu8yuE9xDoEbvpVObQB1f03rwBddsovVbYqDuvQpv39GC2hFUaJcdRzyGW1EPKhxIcMCITNL4ZZhrBzJVhL637qwGkNP4LnA5Dp/ugXYpUYc2ZAj9QBj1QmtMGP/owwkNFj8975qMDj383zplcoDWRKu10islgLEKggKpykPRuf7LZkNYFDoy8i/DvowvOMf3G7baSjvxxdtzQ4OcS9/PmesbCxkByDAYfQloZeM4mz5nk5PEC6H9vJ0abEFXsRmh0Nu7186veTKF/TEkQ+oyQ9A2NR1hR2/cWtE7lwpPABh4RgYEqC90eBQEMO7N0lakYMvgK/GYnp8W8C99TgFzdUNTPQyPDAZ5NrRz7jMdNyi7azb0Lpc3PkHAhQ8g4u2njOVXoC5ojl0OrbKea2SR2Q8EIX3KpHDd+2wLFwpdvtg/iNHuxSi0bLMuShHgf9CwBwvC8vCYonQ/HLERa9S42ot89If6OMJIB+MA2Hu4yzlP8Z7wPal4h8rhcdURjmOAlxuVLDObdi1Y+hgql/Gkh4o8H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(86362001)(33656002)(55016003)(316002)(41300700001)(54906003)(66556008)(66946007)(5660300002)(76116006)(64756008)(66476007)(6506007)(8676002)(4326008)(71200400001)(110136005)(26005)(66446008)(9686003)(107886003)(7696005)(478600001)(38070700005)(52536014)(186003)(82960400001)(8936002)(122000001)(2906002)(4744005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zTrM1nG3NKvaCb+nUM5duM/+wPg5PgVXEs3oFXikotFy3O+52yY/ETluqeBn?=
 =?us-ascii?Q?hGfeb7wc4cNi0sU0Sm7QFSbZzi28qUJgQqm+5V7khcre+uhiluM8meZJ1xg0?=
 =?us-ascii?Q?WTEJmqcOlfFG9kzGZ2En/3oI1vyLUY7rpRxJWq3/89sNBQITaQfs5EgiJCSu?=
 =?us-ascii?Q?aLInXp6mvaCR4BUExDwRs48Nhe9TTxLYYVKXPOhYYES5K/HKVsvJVwkoCS4f?=
 =?us-ascii?Q?I1eJEmtVJv+eNGwgABlpIs7qUlmxqiDBBlP2NOgouxcPSsk5tgr1O9PT9rPz?=
 =?us-ascii?Q?B1ROsN3yFujDo57hjT8haz6froM3vKmxmnZv0BEV0G6q8xYteFItrEWtHqFZ?=
 =?us-ascii?Q?+WQc9CPsnlXWL3i/Gz/ZCGSUx51M7JJkDRnhhvIpCjeNGoQ5L7dNUu5Sx9aM?=
 =?us-ascii?Q?Kd5v3AtbQayuV1ZyS4Q4U6urP/myTMiA+owfTtSXUP4ihPyT+5TIeh84/HTd?=
 =?us-ascii?Q?amNEgDYuVINcMzb96MLu034EbirY4ItucPHrYXU8zek5CSiy93vPBdDE4IQg?=
 =?us-ascii?Q?sgS936IsRETZNdh87aRE/s14Xwcj83djT9eZecvXnE+W+IYIHhUQtcrqfUyW?=
 =?us-ascii?Q?yj9WVFq8djiMHN6Uu6VBFJ6K/jY0vwEw0GUasUnj5PmcZ06qQdtGSkdYfHg9?=
 =?us-ascii?Q?BiTvbZqXe4fqLgzdiFiMJCPDJVR6pWr1m7JrCZJADl5kn/mrKMJMPO20e0T2?=
 =?us-ascii?Q?JWyvtjRV8VRHTQ2PsaUOI3L3PM+znp96uot/sSc225ai/Uix9JscgEKhU1QI?=
 =?us-ascii?Q?RDLJMWCFUAQoriB8jb+yVEFFhWhVB0dwrqYIGYDvL/LPlIkGjjhjpd5S1Z4G?=
 =?us-ascii?Q?mwa4BrfllxRWpxQGrZdy1tpHLjccBQ4WeLq3rP/KG7ZI9tkRkn3KXYj3AUAy?=
 =?us-ascii?Q?h/kaP4zvAGLrCBLHB+ycFU0Fx/P/2pMdfGO1W2kBanVnxaFvExMuQllYhQfe?=
 =?us-ascii?Q?xBZmYFJHCX/RzOGiaT0owUnLyLqQQIousiIwRn97ClbdPoyB+w0+hEQcXqAF?=
 =?us-ascii?Q?gWf0L/FTFkdbhiit1hIS8pa2QkvMjUnFdK4QX/SfEvvXt2YPNioynQSE/M0q?=
 =?us-ascii?Q?UnMazMi58+7sjXleynbhE05aT2pjLRY9utXykzttAppFK3tzRQ4k0LpTFYu9?=
 =?us-ascii?Q?JnEZYg/BIg+ixitjJQs6HuGoVD6BKblP7phzrsI/ul8vpluIBBQ8bqqBLJ9f?=
 =?us-ascii?Q?LgnQxHGQt3EvATCfepQaCibwv0tWIgwTO5BVK4qpTTmYwtW4HwfIxQlZ7J9t?=
 =?us-ascii?Q?xJbWtzEJDmd2m5J0OMuIVxXafKwwPA97fgEkL7g3J/yz6LAPo0DHWugyPESl?=
 =?us-ascii?Q?h7CfWk6dPobB3bjyVcHBIrYMYrvAXPmwtaF2NXn5nmRBa4p8ozfhFA6koW7Q?=
 =?us-ascii?Q?f7lifvPknDJHq6YgscWtkn4fhgWHtdwa62xQLQPTyXZMHW58zsg033fCJ7/S?=
 =?us-ascii?Q?6X/xXq+TF4i35G3NP6TfI3csV7aGr0WZBEM+p0/Zryi+sE8bXy1+kacHvOyP?=
 =?us-ascii?Q?okCGrCztDT45sa83a9LIxpeu3BIFKPOxjEK+ffAmOlAhwohZoeg+4EWmOlvY?=
 =?us-ascii?Q?+ZXG33ko2VD7otMdoi6BB7ogoiHmahQdBICRM/mM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecdd443-49ab-4dfa-f8e5-08dad168cf11
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 17:48:50.7055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9zoVKBLEK6bLizRjAi0KJzb/Vdqf7xuTN2UdLRR1Ypa0oEZesViQvQtxnwQw8OtIjL1Wu3fu0ph7+8ByzH8HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> As the comment of pci_get_domain_bus_and_slot() says, it returns
> a PCI device with refcount incremented, so it doesn't need to
> call an extra pci_dev_get() in pci_get_dev_wrapper(), and the PCI
> device needs to be put in the error path.
>
> Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server pro=
cessors")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied. Thanks.

While this fixes this particular leak, I think we have a bigger one in many=
 edac drivers
on module unload.  I don't see any "put" in the module exit path.

-Tony
