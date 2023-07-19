Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2D1759C6A
	for <lists+linux-edac@lfdr.de>; Wed, 19 Jul 2023 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjGSRdN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Jul 2023 13:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGSRdM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Jul 2023 13:33:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370EB18D
        for <linux-edac@vger.kernel.org>; Wed, 19 Jul 2023 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689787991; x=1721323991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VmLOmQLSyKZ15Ak9pfhpzv1Z2m2SK15bTpEpqWrC8K0=;
  b=fUaoiPrRP0no88W+w+cP48x6UNOvEPFXyxgNa1PiWwzGNSGSLk4J72aW
   LgUz9y6Zr1YjddUIf80+OrYs5FEhkBmEX3ZagxdMlPjAybdwKfdOMwONm
   LdbfRqE0AVG8l/KDBm9DRm+PKkEfhCF3vSvtZ1EVCy1qejLZ1qoEG32cH
   U2ioOjUEIB65h+SKRvZqwYhRsmI7l1MlC1O2P4y29/QVCkWyUnZm8JEN4
   lTui5i8ZFx+K73migCtXNTBl4hlV3bCA1AujwyU1HnWpy3AyMJBGYXvvf
   CMalxNg+0J+PLnEZsLxsuVEfJ+FiIBvevkLFo/c5pXpmAgU6iH8fGxE7z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363990865"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363990865"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 10:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674393375"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674393375"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 10:33:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 10:33:09 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 10:33:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 10:33:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 10:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ohc0Or4aOLLb3qAa5tOd+nNNxnQZzIFlCBoLRr9GrbIlWAxsuho6eAeuxvVreufoHaMyXNFkfg4h92yWZVWDqAxSpYskBB+pWM16WRCheepqLxUyF//wF2rfcNQv5UMaW5ATO+IJh4sGwFLUaCSpxQ+44NsdA+iCduWOaeJxBV7LhoaEU717YZ3pKiNInwhTNh9oVWVsI3udmrrvk7QKUFZOpxSCL21cwglnCWQ3W/FRNfvidE0xMfbndLf1PKNBb5C2bYS2PrulLwQjYtDY+Targ4Yx1gD8yQ+tWCiMj7s/nZ2LeYAtGVPGHNFAl3a/vmfETMcUCNK50RdB7qd9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmLOmQLSyKZ15Ak9pfhpzv1Z2m2SK15bTpEpqWrC8K0=;
 b=Klq3yAJaMbwonoviFCYHRj7seUO1wV/eYvisSxlUhquKc9NYQZigaByTJ7FsfBLSNK5dsimvYZIoOTIbuK2vMip8navY6s9k4U1xliUtnkoqYVLtmk5NOCxf9aIbS8dXR4m6siqVjP4imTCU5Uz8JK7z1YOa6LEd7G0gJMiagm5698Pjclvwwi+IHcWUNAF7oZ13LANEDkIOPWhwW75A5oQzJUkjwHIjkVcrxihm9/4iNcGttgRr5neOF7AeWeSfBG8BZzK4y86DYdnBkjEVa547cLpunLzQiXaEbKv3jGoyS6ckOEeCNvTpz15xSLvtC0GP7HWWkEOP2jTsNwImSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB7722.namprd11.prod.outlook.com (2603:10b6:610:122::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 17:32:56 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6c4d:b433:cf0b:8a5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6c4d:b433:cf0b:8a5%7]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 17:32:53 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@ruivo.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: RE: [PATCH v4] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH v4] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZuMKuvVFae45rU0O06dz/GcPawq/A1KCAgACHuNA=
Date:   Wed, 19 Jul 2023 17:32:53 +0000
Message-ID: <SJ1PR11MB6083D965F431FBF43B36FDFBFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230717152317.GA94963@cathedrallabs.org>
 <20230719092619.GJZLesOyHrL8JQyDZN@fat_crate.local>
In-Reply-To: <20230719092619.GJZLesOyHrL8JQyDZN@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB7722:EE_
x-ms-office365-filtering-correlation-id: c9acc3e6-f727-471a-96c5-08db887e2e8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/lrI+B4s7yPEls08J5ItRaRG6cLFRo5JaIBXwVrxAOU4kUALjhPZiIJCLl3i0Ao5MqX7JodArcmZnGeidfyqyF8rid3pcpGwSmUQUpzOlJyksqgmKsW1qIlKUDRn2D7vvgHZYp1j4c7Q2L48dQjfDsBXcIthah4AwRxqOMbiUW95UwVi+o34bkCRJbF7XyZOli4p0/HWW+zTYbYFYBw8yDXbaL1xAqVQ4t9FCX+sTrgVNcwi6YGVDylVhljYvfrEMAOxTTbE1SQhANpPBrsv/2Dz7f/55NTUEcCKF2WYeqYWrYe0B9dUjQG6M7xdvK8IuNrRa/IpMPLvDiI2IkwYPs8/tcz8PG1F9xorzocCWwIkvt1usB6+jCQkIp4V0avh+NkA3I0Ugj6xHoRNVk3vSJ77CMJ53RLejFpGQCrlSDOufVfDQ92hq86aVqXoAJc9DCZ5Uq/bPQ0WoqbHwTZoLR972/7dqXKXvE5eXgZox5nZK4jfeZPd4a33+wae639ziQsgGsMNPilz4fO/QMt7L9ufX4LkMOdGOPCyDos0CH7Nz11uoz+JFRcyhHf/+0dbbniMpYuSht/tusVmaPq32QDC4POL9aX1P7oK+UBLkmlx9Si1uEg2kuztG1LYaE1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(7696005)(9686003)(71200400001)(33656002)(558084003)(186003)(86362001)(38100700002)(38070700005)(82960400001)(122000001)(6506007)(26005)(55016003)(316002)(52536014)(5660300002)(8936002)(41300700001)(8676002)(66556008)(66946007)(76116006)(4326008)(66476007)(64756008)(66446008)(478600001)(54906003)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWQ4MENMS2JQb25EcGkvNEZvRlVSbitPaVk1d3BkL3RNMnRrSlJwYWE5Y1E5?=
 =?utf-8?B?bVhIWFFDa3ZpSXVaUDltZ2FFVXo3eGtxamcrd0JJRk5xbTlMV1ZWVTZVc1or?=
 =?utf-8?B?ZmNiTjJlUVl2djFPSjYxeUEvYis1dCtuTk1hbWJUdFlZTXhZY20raGVTS0ha?=
 =?utf-8?B?Mk00OEhZbVAwK29YbGczZHRoTTVDbnB4R3daSnUxZFlpUDdhVzY4bCsxUDRC?=
 =?utf-8?B?YlZSZVkveUJ2Q0dHL2ZRNGU0dDBlcEpsMlBnKzk0WkpvNVVyTVBKUFd2M29G?=
 =?utf-8?B?MWdFMmdqekJWQVdzTVFkTnhNWTJTZWcySmxrYnc4QnJmMUc0QWl6MlRWU2xJ?=
 =?utf-8?B?SzlaTEFOVTk1T2R3SUllMVFUK1JaRCs4VkpnZnRzQ241RS9qekE0VGhMZEhq?=
 =?utf-8?B?V2s1Z2Q5THpoWkZZS1RoRCtqcVZoKzB3K29KRzJvdVFpdmxhQmdWYWpta1gy?=
 =?utf-8?B?M1ZtMnJZUHdhMGxvRVA5SlB2MFZEOFR5Z0xxbTJWRkJDMWxTY1p1Y050UHNq?=
 =?utf-8?B?ZzJNKzJRUkR6RXhac1lieVI0Uk54a2p4VVFHN2pyWUs4QTB4OUQ0bGg4cHpm?=
 =?utf-8?B?U2RZTTNhZHNsZjNXRkZBYUNCK00wUW9uOTBWQXFQdGhkM3hhTjF0TEdYWFA4?=
 =?utf-8?B?ZEszWm44TnhqTnZLbWVXL056SW5ORGNLRERZejVjbmxiZnBoYXBEUk8reWVq?=
 =?utf-8?B?emtock55cVdTSWRWYmMvb3dwM21TMldKNHFKWmtMSmxUVUVBSTFoUC9sczc5?=
 =?utf-8?B?eTdaM1doSU8yMVJXQTlhdkJnazVVTDVJWTI3cjgyT1g3Y25jakt0TEFJNTcx?=
 =?utf-8?B?UjBRL2lwQnkwdVJHY2NQMmJWSkhIbnkzRVN2YjE5N05PRHFqSXpuUzlmeUl2?=
 =?utf-8?B?RmN4VEZqc3JqV2VFUnBIQ0hnOWU3eUdJV2w5QmFLVzc1UWJKb2p2dUZWemht?=
 =?utf-8?B?a3VIck81bFJreEpzb3R6eGE5ajNITnhHNzBCZ2NiMW5hanJITVMxQ1RHK0lD?=
 =?utf-8?B?VU9KQkx3eGl3OGRXOUNnOEpqZm5GVWpYZ0p3d3NUNFJlWFlZbDdRbUtGdm1w?=
 =?utf-8?B?MFFhNmJMT3B4TUFINWhaZitRYkRJZkRaR1ViVjZ3bVlsdVh6Q1lDODBySjBE?=
 =?utf-8?B?YlJrMEZ2UmcreUtKTDY5cUR1YTNTU1hpVEo1eFFQbVpmaSsvT2VIWld1YVRG?=
 =?utf-8?B?eVpUUklIZmVaYzhCUElpcW9mSlFWK2NkaXZhNi9wMi9CdVVzRzJDQVZPMzNo?=
 =?utf-8?B?UnBJMCtDWGdibEFyOGZFTUpJN0d6UVdkb1lwS0lMaUJma2swM1JIUWFlTkNy?=
 =?utf-8?B?d2xMOVYrc0JNU1dQeFVvODNGdVF5NDFYMFRyRU9wMVVvQlV5RmNaOVpST0V5?=
 =?utf-8?B?c2FOWk4vemQ2NXlMeHp6emtNRE4rNEtUT3dBQnIvZXJ0NzdtRzYyTVgzNTkz?=
 =?utf-8?B?L2kwNVAvNEJLaDNaTTBoWHZOMGpNa2c2TUV0TGx6TFN6dlBTdzA0NnZTYlVs?=
 =?utf-8?B?M25Mam10ckh0dWdsb3MxbnIzWGpWRkdaSGl3THNHSFdxd0xtV0lNeUFZc1lN?=
 =?utf-8?B?SWNWOExhTXhZMU1nRGNKS0ZUZmVkcGlzcmRVeG02eFUxRzhKa3NFYmpmZ1VQ?=
 =?utf-8?B?MHE3b3JSV0FheEc4RVZTUE1GSHp6dHJQWXpKMzhjWHNhSDN0VWlJZnRqVE9Z?=
 =?utf-8?B?eC9wTW5PR3daUUc5Y3g0QkNlVTRtOTJQMnNUdFE4NVYwemE1b0IxUnRobmZa?=
 =?utf-8?B?aTQrL2tmUUZSbDBELzIyTmlEK2NwdjdaTWdjeEY5NU9wRWg4NmhXWEQxTjZV?=
 =?utf-8?B?dDNtYTVUcWhZN2hsUUhxV3c4Z1hBQVQzTC9zWmR3SXF4MkJmTFpXaGJBU0hx?=
 =?utf-8?B?cDAzWlYyN2EzS0p1QnVuSTZyVFBOenNieGFwYWc2Wmh1UEZDTzVRV0Y3QlVa?=
 =?utf-8?B?dFZ4eGd2czFOcWNkUTVISjlqY2daa2pxVHJucnBnRFZzSFNZTDBFMTBVY2Vi?=
 =?utf-8?B?cHJWaW9IZlZRek13SVpPUTRVdWZacTJNTGlETTVLWnh1WTFNUy9yWFFJZ0c3?=
 =?utf-8?B?NzIvN1pLQlorS3RaZWNoQ3VWWEMyUFFPdFQwY0RoWGkwOVR5a1BiWE05OG8v?=
 =?utf-8?Q?LWQQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9acc3e6-f727-471a-96c5-08db887e2e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 17:32:53.0982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUhicLklBOdfcYKF/YcKP0BYowuDbOZZt+QHDwxgZioUryb286XyjlYYzbJPE/upqjHHiPZbWHGNNN+xYQNi5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7722
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

PiBEb2VzIHRoaXMgd29yaz8NCg0KWWVzLg0KDQpUZXN0ZWQtYnk6IFRvbnkgTHVjayA8dG9ueS5s
dWNrQGludGVsLmNvbT4NCg0KLVRvbnkNCg==
