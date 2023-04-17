Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431486E4F6B
	for <lists+linux-edac@lfdr.de>; Mon, 17 Apr 2023 19:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDQRks (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Apr 2023 13:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjDQRkr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Apr 2023 13:40:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443F1C643;
        Mon, 17 Apr 2023 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681753207; x=1713289207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lpjtfq/NzMJZHxjlg8YLY7B0rS1k+wGwxF3o08529/k=;
  b=AjIuq+6t8jvDmBS7xb4CFPdRWa77/UeyYPz7cULNhVxCpv4D4bQDT7D/
   bGsK1m9ihrKc0L1U26bYcWhTHS7YXWpzkeVH+u3ULXJ4HGvlZnMeypjmn
   2lI9ClwMFqSdWcKJsUpzyMAbVH0uFLniD1nJt/wOq/52ugZL6wNd6qTYk
   VMP623p0RhJ10idpzhJVgTDTe54K3K3hQ5k+O+xEk+2LxU9OQ6ruhjHcm
   o1dvc5H/8z+wAUssE0HJJx8FoPpRmknGu2DVodltemquAwBuLAJbCWviF
   m1NpJnEfG2NTgG7FDRbWYA9VXh8/hudo6OXeBu+ibkErrhDP6fyUK8bQt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346803349"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="346803349"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 10:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="690744392"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="690744392"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 17 Apr 2023 10:39:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 10:39:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 10:39:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 10:39:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n56K2OgWML1b6oDIa3XflnfDNzpaZYAWnktWcVc9DCuLvVe0Stvz3WMs4cUsnaCJl0wfvZAHWEC9xmp/EN5LvX+uRwsSxr4BFrBdccnX2trU5+nSvrTdXbis9MmstpmaEEmP+JjFpZKZuY97yfX+7o+WKs5jH4WLaxuI3d7ey8dK1o1cZDJfl/HP7bQeW+Wgv3+lefzgG2vcwmDex1jDffHPTefDcZzFTwIfYWU4ZBwBb2Q3YQa6Sm/Nj3pvnlJZomVcmhHqWjG9wEdoI/MofxzfNs7DbO5AXtHyaHysZTJiNzE6s7niu96b4UIhIfLIoXYI5ylHPAChrHNXwARg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpjtfq/NzMJZHxjlg8YLY7B0rS1k+wGwxF3o08529/k=;
 b=MA1ja02gySUn2bA918Rq2zlUCi2FOWyeddfc+8qHslHHO4ISbLALJf2zLRPWUyh0I8b0+bfzkcQszBW8EdWLkJoeWjELjfqI9oSgagnKzCirU920pdv0SJsQ5hbW4rYRlcyfGg1AMH7FV45VS9X8bQ4mLtcaKhahCriI+k21/B/Ya37ppDBoGRXckxrfI8E2RZ8p0I4PVtr0fErZZP1ImmB0/XoonejirS4A/9mFWY8UQ7QIJFgrzZgGuu0j0cEn2KhrGy6CwS/S+k8gt/L5TxAoOxOU6hwY6uo37bG/wQu7dJTimh1bjVi85sQMM0+3w9GvnIE25yR+QHrgJdffZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6662.namprd11.prod.outlook.com (2603:10b6:806:256::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 17:39:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 17:39:50 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Thread-Topic: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Thread-Index: AQHZcUiOiGs+Y9zOZU23tA/yQJ0VrK8vvZSAgAAD+QCAAAJF0A==
Date:   Mon, 17 Apr 2023 17:39:50 +0000
Message-ID: <SJ1PR11MB60837EAC6B0AA28AF7D16784FC9C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
 <SJ1PR11MB6083E6A167F4542AB439F09AFC9C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7b316c31-ded2-d6d5-0315-dd4906ff833b@amd.com>
In-Reply-To: <7b316c31-ded2-d6d5-0315-dd4906ff833b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6662:EE_
x-ms-office365-filtering-correlation-id: c5523457-6568-479c-7145-08db3f6abece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NVFSpwqekBvcyKSpc/OQDEP86om2yba1Jyv6vgEZENA9sHjP8s1v9aQzaQj8Ai3wf6u5f5vnrWvBm5mM/FEdmoVHSYl1uZBXObumLxxB/aN9NJkWBgGhQfvChLxN9A4bqlRlCdEkmS1ZzA9mUtAuTPAnVKDWK2hiwecCVgAD3pN4jT/LzuVWtkW1EHY2hmcgmpjAbLks2NZaRE7PVeti8sMoWQwjcoNk4bCww/kgq/DApTDLJak9ePFJMjhfGi76SHOPoMVPmUxxKXvEcj3tBnajaBefJQ7vNfbUUmIKpt+nS6CtbtwzqL7SaJpmaSQUkqiBU37rAbveN4L7hZk017XeqNHfKDeX8UjXEK2ta08UetQJIe/v76pnUPrx3wDFkdI9dO9jxVjb156ikiTlQF5WiKsv+rJT7pni5EoOdsbv/TJrmaU0LZmTEUxiSj7TMW10KUVftWSRA4tzHqLh8mLd+5a2UOaeZIQXRsUGGmgpm9waA0iQw0lC/CpaBTNLsvup3oRibbQIO+Q17Fw4WMpA17O17n+40t8ce+Ti0N3Hms1MOLnr5QNjbaML7n9TEmHhUAZx86mDJ9RQ5+hncSgOWiLXLei0azOnPoHTcFdKMPxH6SiU6u29ueXcyQmz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(122000001)(2906002)(4744005)(82960400001)(38070700005)(33656002)(55016003)(478600001)(71200400001)(7696005)(38100700002)(26005)(6506007)(9686003)(86362001)(186003)(41300700001)(316002)(5660300002)(8676002)(8936002)(52536014)(54906003)(110136005)(4326008)(66556008)(66446008)(64756008)(66476007)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elhPNDlpNkRQOTIyYlFRcVNjTUt5Y0FjcThxWU52cXpsNDZvSWdtRmFhUlFX?=
 =?utf-8?B?a1V6K0hjcldZYUhES1RqRVF4NGkrTk1sVnFHN1FJTEdHdnpheHEycXY5bXZZ?=
 =?utf-8?B?S0ZtRkhjcWNvM0hHRmhDMW52QjhyWjRZTlhjUGxMYVpDRWp2Rzk1eU5mWVpI?=
 =?utf-8?B?MStRT01ZV1dqZlNIN2ZXQ091UG1RSk00U2x1a082OXcrT3M5bndldzY4Nlpy?=
 =?utf-8?B?Z0d5SHVVWGtFT1ZLSU1vZ0k2K29BMlorSlQ1enRseFhWTnVMMGlhZnF3czZ4?=
 =?utf-8?B?NGY3dFZ0ZDlDTFozSzI4amxMMnE3Y09FcjFQVS9uTHF3VlpOY0dmcis5aCtT?=
 =?utf-8?B?NFRVRlhNdHlqK3ExaElRaUVNejZwak8rOUV5aHNKaGpWdlBvVXk3UkpuTVd2?=
 =?utf-8?B?aTBYS3dPTjV4czBZaXowalN6R3NZaExYdEMwcDJZbEg4aE5NT2xNTkRvQjV5?=
 =?utf-8?B?MFVxeXBSLzBXSDhmZVpUdUZYanBxRGR4OUlMaG02OXpTcVpEc0RYK1JkemlX?=
 =?utf-8?B?MlJ3a3hsTlgrb1BPaFZRQWlhZmxHVW91SktHUkhXNEZVVzBPWjhoSndKdXBs?=
 =?utf-8?B?Z2VIRlZQWWxWL1RRVlovT1Bxd1lCZW5JVDlWZkg1UXdQemZYWXVWdE5mU01E?=
 =?utf-8?B?bmNXbnJTRGw3eXBmK29ab2FhdVpqMlFNdGdqSXZVVXJhU0ZQVWVKU3ZRQ0dt?=
 =?utf-8?B?bkZRN2d5Q0YwWFd1TnlyazR4RWEzdytid1VzZUhlNGxDYjhZTk1hbFRqZE5C?=
 =?utf-8?B?dytqUzNCSE45bFBscTk4NkpQd1VubUlDQ0kzQVNRMGd3Z0hlOFp6bjY1N3Nv?=
 =?utf-8?B?RERTQWhtdFdxVndRcEZRdlJJbkw3d2JsbWNBRkhqY3AxWDlCM3ZURWRGMU1G?=
 =?utf-8?B?T2NlREgvZXVNTS9jZ01aQ0gyTVpBYmEveWNoN2Y4QVdld3BBajY4Q2VTMTFQ?=
 =?utf-8?B?bzZrMktnazR0WmxHbFROK1JaRDJSVjVyNE1MUDNxck1lbjhQVVNFNWh5Mzcy?=
 =?utf-8?B?QnZWTXo5S21aeCtPV1FYZVZFS3A2L0VkZWdHZnpUa1hUUVJDZVhUMkVxbVpC?=
 =?utf-8?B?RURBVjhIRm1Da1FMUENmaXdvTmJRZy9kQWhXek13NmJJYVVJa2VBT0NxN3pF?=
 =?utf-8?B?R1lrbnFBamFOd2EwbVN5dU1xdm1GR3ZWUVp2UUQwd0piUENUZks5cEJLb3lQ?=
 =?utf-8?B?ajh1U2tkS1dkeE45NjFSYkFwRTExWElzSERSVW1GTGRQODVqeVVRbzByRHcw?=
 =?utf-8?B?Zm5Yc1FxeXBOSnRueXNCQmZuUnlUVVA3OUQyY0t2WkhuZlNOemtkN0N6ckkx?=
 =?utf-8?B?alZhL2FqU0szbG9ySVJ6eUlhN0QrZ2pJUUQvS0FQbmk3UWZyM0RiUlp5bDJh?=
 =?utf-8?B?cU5SVHFkd241Tk0xUDBIemlHNHpjMWVGRjdDVk1tb21oYUVLSWdTN0NPYUg1?=
 =?utf-8?B?ZmRSYVRuWGtrdmZDcjdKMXdqUWpBOGRBckFybmtZaUgrbDhxdGtFTjYxM3p5?=
 =?utf-8?B?WHlGKzNyTTdVZ09CU3VERGFsTkZqVjZ4NVFORnZtcGQwUDdxSzdDOXRUaXdn?=
 =?utf-8?B?cEVPQkxkdWRFbFFTQ3NRempHTnp6L2d5eERJOTV2amg3RS82dU1nUW5pOFY3?=
 =?utf-8?B?NFBkSDZLUjRSUGswMWZwbDh2UW82aUtKZ2xUc1M0d0dvZDd3SHZHV01DYlZs?=
 =?utf-8?B?MThwRzFNTUM5SmN4VWNJL0UzTE0vU0k0WlNiSU5NRE1sRFVNcG5MbkNaY0dB?=
 =?utf-8?B?dHZxM2F2SXZDSlJNNi8zbUdHRjRxRDYxeUlDLzVxUG9kdENXbXFKcXVISTFj?=
 =?utf-8?B?QmRVajFrRk5zcE9oMFo1amw2bTZ2MGRQTkc2VmxDR1Y0MC9JUVdzMU01MkN4?=
 =?utf-8?B?aEdmZ0dOL013aE1nSGdKVUViWnZWN1hzbWRKdzBjb0pNZjZCYVdCeG9vMHBR?=
 =?utf-8?B?RkxydkU3eHlGL0hFMSt1ZXdiM2pHb1J2SHk0YUhlRU14dlR6b0VlVU13Y2Zi?=
 =?utf-8?B?QldzT05RRU5GVVFWOGlvYnJTNUJoMlpLakZmeUZPcmRybEoyazFNUU5GRGhV?=
 =?utf-8?B?Wm9WbE9wOElFclRBejdSZkpWVWtRMWI1MmhpOE8rZ3h4QWEvVldTRk56dTgv?=
 =?utf-8?Q?5PBE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5523457-6568-479c-7145-08db3f6abece
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 17:39:50.2908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDkY2BXgEJ1k7Jkj4/fe81j5linmvB0HJyG0e9Ohckj/7OmXjvURbZF65G5NuZpPhgmD3aqqOUXmnlHNOKItww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6662
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

PiBUaGUgZnVuY3Rpb24gZXhwZWN0cyB0aGUgZGF0YSB0byBtYXRjaCB0aGUgIk1DQVgiIHJlZ2lz
dGVyIGxheW91dCB1c2VkIG9uDQo+IFNjYWxhYmxlIE1DQSBzeXN0ZW1zLiBDVEwsIFNUQVRVUywg
QUREUiwgYW5kIE1JU0Mgd2lsbCBiZSBhdCB0aGUgc2FtZSBvZmZzZXRzDQo+IGZvciBsZWdhY3kg
TUNBIGFuZCBNQ0FYLiBCdXQgdGhlIHJlc3Qgd2lsbCBiZSBkaWZmZXJlbnQuDQoNCkFoIHllcy4g
TG9va2luZyBhdCB0aGUgY29kZSwgcmF0aGVyIHRoYW4gdGhlIHBhdGNoIEkgc2VlIHRoYXQgaXQg
Zmlyc3QgY2hlY2tzIGZvciBTTUNBDQphbmQgcmV0dXJucyBpZiBpdCBpc24ndCBvbiBhbiBTTUNB
IHN5c3RlbS4NCg0KICAgICAgICBpZiAoIWJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9TTUNBKSkN
CiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCg0KPiBUaGlzIGNvdWxkIGJlIGV4dGVu
ZGVkIHRob3VnaCwgaWYgb3RoZXIgc3lzdGVtcyB3aWxsIHVzZSBpdC4NCg0KSSdsbCBrZWVwIGl0
IGluIG1pbmQgaWYgSW50ZWwgbWFrZXMgYSBoeWJyaWQgc2VydmVyLg0KDQotVG9ueQ0K
