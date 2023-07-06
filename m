Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601EF749ED7
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jul 2023 16:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjGFOTU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jul 2023 10:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGFOTT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jul 2023 10:19:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9309DDB;
        Thu,  6 Jul 2023 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688653158; x=1720189158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RWc45aZbWnwooACG8HxSA43cQJVOp8TUsgDNmIvqWEY=;
  b=NoggWvafue6ICrq+IS57B+qi73+Qw2r6nrx/+O4I6Jn9r7Q/26eFesh0
   nI9VafExi+Qj7ZTqbIVHdtUWYqSu2K+us8yMsabEoe7dbGzSnBtVySdwf
   v2nOUh50QFeRUNo9u9bXTjFLcG5zcah9ljOqS4O3y5f1JlRvSUkpOfKfu
   K3FpFOuQpi64deSN8mx07DBYAx3wDoXHSYc/E24FtnclFds6xL40f+6SJ
   qLtGsqsr7lqtiHQ8QgHehtwNlENImzZv83mj1ECbMknghKOZdQrSVuST2
   ixFHTtSPq9KigT7Ack0QuIES66M1N287rafsNZDZ4chJPcjOCqImsXM1Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="363649500"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="363649500"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 07:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="696859529"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="696859529"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2023 07:19:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 07:19:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 07:19:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 07:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyDFpNp44PcOTfRiRXXr/iW1sB4A25fOTf7cjiR1oFwsISYuYzOON9UKk122fGaiMyIDhAhwYZHqR1oaDEOPTeAPILCY1VAY24k9eSQdRnIoq8+J1kdBNAXC/f2aAeez26ZjWRAHSwfUAJVBEJEvouIXqfiKBANLIk2voeExfEvIKhBT8QprVJ12z9pAdTNwBJPv4xyYz7WgDHlsGYfgmS14b9AAEfxAkVMEhKl4/acOrkCIzE7vQQx8ZOgRiMqeCueqGJiZqRmeXgnJ4tN2IIhCuwP8ETCMB4+8dzANY3pI9Sgf1TaN0+c6cMAhfiDnxGgmstLTZeHHTgqJbMUtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWc45aZbWnwooACG8HxSA43cQJVOp8TUsgDNmIvqWEY=;
 b=JdGfg6vLsbfUlqcfLmqaBdj3Ltsi1Ix5tx2zMN3T4FV241rcD1JebsGAdBbA44Oua9zsL4mYyIcIFKIcQnPAQuxx0Vjcz/uto3fkh6DQteFJdyosU7J4+0abo9u0l5qDVh+CJoa9aQv9YJocrsW5NCld3Sg27uTXyFuMTZJZJ88Kag0dOu8t0RVMFuMph3mpstuX8akagym16Lww0CyGgsc77/3MfJnTFds7AbPJOSOH3jhIGZAR6AaDRAObmCpdVU4EGCwh4Dm7XuJ8n35qiTwGNjvXic56ml4a5DOjIB66qDsBZnlIIMU+j4BL3VEPThjjXRuqThvso1h7spCrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 14:19:13 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:19:13 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Luck, Tony" <tony.luck@intel.com>, Koba Ko <koba.ko@canonical.com>
CC:     "kao, acelan" <acelan.kao@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM is
 absent
Thread-Topic: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM is
 absent
Thread-Index: AQHZh6cRf1tM2cXSPE61hdftzjZJ8a9c1sMQgABNHoCAAPUEgIAsA+8AgB8zmYCAA8fpEA==
Date:   Thu, 6 Jul 2023 14:19:13 +0000
Message-ID: <CY8PR11MB713477E4E5A303D3A1091A1E892CA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20230516033133.340936-1-kai.heng.feng@canonical.com>
 <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
 <SJ1PR11MB608384487F94EC485C91F47CFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAAd53p56=CpWpPEOD2YdCneJX-XxO93MHMQHbLRB7VCYweW7SQ@mail.gmail.com>
 <CAAd53p7rpY7uUE-zBQOy3XBmB_JO96qYxkSZr26nZ+qcdT=COA@mail.gmail.com>
 <CAAd53p41Ku1m1rapeqb1xtD+kKuk+BaUW=dumuoF0ZO3GhFjFA@mail.gmail.com>
In-Reply-To: <CAAd53p41Ku1m1rapeqb1xtD+kKuk+BaUW=dumuoF0ZO3GhFjFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6757:EE_
x-ms-office365-filtering-correlation-id: 8b9989ba-806b-4176-e2af-08db7e2bf976
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /GCRaK4iIGLqnwaYaklEyH8oMFUmdOY5YhQBVYFaBqp9fk70pEV8YFmi3+6X0XzYbWs/WzNjJ3r8G7Hrt34e2H2IevBNCOXbYCGtBuaqdkxksh+a3bpa5ulLDksropEWSpxJNkfXk6PeZly2nDpwyYI76WqmNZNJFpwFHDh++Dkid3Ua2sv/j1Sz7h0QRjVJbPfty8UIsiMIjgwvcCNPNzYzY6dS3CywunDuupiMY3tf43nuF7mEWJjzuBDhvArsMMYp6Z0BzAsVJ+sbQ61r2UhbYzb7nHUMUgp6zVjpGBEsfPfZ7S1TsEFcu7CpAjTacmTGT4PWCnfLSYaCvZG3b3MQ4ds3t98wiRL4WbHRB12TEUmaxg5GRC17JX/S2Oi9zw+WMGgaDYDuOqQc4sO3VVaM+TYhHgFio2dNWf43OgHH5PwRtY5p2B1eVblo9NSG67GHOQRliS2efoR9yzBN1nGiVeJCkEj6OOEUx8PtphfPj5HzOKUDifB3P9sUr2+c89AiyuLG1/41N7dR6jkA3ZzqanCQziJgBwk2OQ7V+0srW9qmK3c4+sLk9Tz4OiB27uf6wfQYuEpdQh4XtxjnpNc4aPIqByJyp1jTvaLvyIk1V2i4uQ1B40bc3VNwliiF/98XDtFaHWY0Iq+I9KGqTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(6506007)(54906003)(41300700001)(7696005)(38100700002)(4744005)(83380400001)(71200400001)(122000001)(82960400001)(186003)(9686003)(110136005)(86362001)(55016003)(966005)(38070700005)(316002)(478600001)(64756008)(66446008)(66946007)(66476007)(4326008)(76116006)(8936002)(66556008)(33656002)(8676002)(2906002)(26005)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVdvY3VzODFKdGsvQkJpbUhTMnhpQVdVZm5xeFlvRWdRaWhEdlNPQjJ6aytK?=
 =?utf-8?B?RUZ1czJsSElwVVU2N0cvUUVibUd5MVAzQk4wbHZ0TzNhTDFiLzcydk1qbmJ0?=
 =?utf-8?B?UFNQSldxZDJ2bDlDY01WbVVka0F5V1ZXSDgxY3Y3QUN0NTFTNXF3NXZ4Mjdk?=
 =?utf-8?B?RXNzd1ltRXZ6S3NlSi9tOCtaR1dCVnpaWWt5QlRFZVpxVGFpQ2ZjM0FVcVpq?=
 =?utf-8?B?VlMwTXhqRkFNRzJ1djYyWkErTENxS1kwdWgxalFJT1hMbVp6NzliUTBnV0kz?=
 =?utf-8?B?U2RHUFNjWHhVam1ldDJuTzVRTzZPWFMzNUMyQXRTQVV6Szl3WjBIWGpmMW5w?=
 =?utf-8?B?RTZRNk1TTWVEQzBNUGdtbk5pUDJtYmdRZEwrV3V1Y3dJR3B2ZHRSLzNyS3cy?=
 =?utf-8?B?WmZmeUUrcUs0cjB4TWJVUjhzQTk2K0F3VUFiTVNOc0prT0Fvby9seHNtb2hp?=
 =?utf-8?B?WVU2ZXNLY3JTbnBaMGdTRU1EMTYvYjN2eXRvbVRBVk5CMmpjcW52eElod0dT?=
 =?utf-8?B?ZC9QSDBEQVkxRmZGRzY1cktFQ2YxSWpiRzVmTW1nK2NhYTBDS3pxNTcweTJE?=
 =?utf-8?B?MTdHVndMRnRLc1c5SWFPbnQ5WkdIRTR2eDE4dEtqR0tYbVdsWFFIekI4MnR5?=
 =?utf-8?B?NHI3R1hYeEJQUXJJVjFJN2pzNXQ1UHF6Zm9DaVVBSDRTaWlsMU9ocWV2MUp4?=
 =?utf-8?B?VTJZZDhUb0hxMy8zTXZMclZBaUkyWGh4WkYwazlCS1BrWUhxQ1l4N0tFOVha?=
 =?utf-8?B?aVlqQjBUQ2ZiK1pWcExqUzFlRU5RTTFqYXg2WGZXT0NLMDI4NXNZalIwZWV5?=
 =?utf-8?B?eno0ZlNsK0xJRWtVSEdQK2E1UkZ2K0dFMTFCOTZVbmdMNnAwSWxaT0ZlNC9h?=
 =?utf-8?B?azR3NlloeUFzSU0xMUxDSGFDQXFST1Z3a3RVNnlqemJjT09DMVVMUUJrT0d1?=
 =?utf-8?B?ckE3UXlkVUp6WE8rdjhzaFFlOHZ6eG4xTTErZEVGTHJGYVZ4Q1dLVXM1d2di?=
 =?utf-8?B?NE9ObTdMVFhiZFJ5cTJ1Q1VhWk1Xby9iSDZMa29QaCtYUWhqWHI4c1l3SHpK?=
 =?utf-8?B?TnZZS2k2MUF5VzdONXdMSDFjbGYzdVhXOUZRRDh6L0FHMTlYOCt1VklUOHVy?=
 =?utf-8?B?STlQQTB6eFYwM1ZmVUt2enFuOVU5aU1MQUhFcVdPYWtqdHhmRnFpenYyY1Z5?=
 =?utf-8?B?L0Rqb25YMHJKTmlNMDJseWFRellqY2xjeWF5b0RhREZHY29FekVndU5oM21t?=
 =?utf-8?B?VXkwM1V4QnhJRy8xaXJwczdDT0FMSHA5VVowWCtDRmFNRnVNWURMaUFPY21V?=
 =?utf-8?B?Z1cyeE9jK05KRDQvWDdsNlEyOEhxWVhTZ3Y4VmkrME1keUdYR2FMZ2Ztbzh5?=
 =?utf-8?B?OWtvZFBlNGgyaXM5b20zRWpYcHptZHFVWWpDN2EvSEkzYldUeXYrdGN6TkJs?=
 =?utf-8?B?NDVvUE4xbWJHdmpKNDU3Zmh0ZXYxaEQ2cTVWODhEaVdGNVYxN1B6M2IrNS9l?=
 =?utf-8?B?Q3F4NENITkhha1d1L3doOTdtYVg3bDkyMXlTbVZOYitveGExT2VKRitUV1di?=
 =?utf-8?B?NGJVUFlFaEpHdzJhUjFKV1Y5aGxyR0JuYmJKaEZxTnl1MCtHSXl0MEVzd29z?=
 =?utf-8?B?YnNiQm5GUnNaTTJsZWdvRDF0K2tNcW4yZTNoQzJlOFFpYjRoVlpJZWhSRmJB?=
 =?utf-8?B?amRFclh5MUxvd3NxaXAwUldmaEJvdkRiTjN5ZXVKejlqRGI1U0hhM3lNSjdh?=
 =?utf-8?B?WTRsRGRkNG1Ua3Vib0pGci9ELzRYMjZOWVFwZ2U4UFJ0c3pycSsydk1lN1N1?=
 =?utf-8?B?MVJqb3V5a3FBNlF4QmtiU2s0eWdQYmx4WjZkRHN2bFB4NzZjUm13Z0dPNERR?=
 =?utf-8?B?N002RjZSbDBLaFFITklxVUlHWEVIdmdLTU9oaElFSmk1UUd4a2haTGJIem9V?=
 =?utf-8?B?cHkvR2t3cE5ac2lUb0IvSEFBM25rMWVLcHNRVjFTTWlXcEV3Rlp5ZU52bXhp?=
 =?utf-8?B?QStMRFFNbXZpREhXWEtIQ2NwR0R1VjgyL0xpZmdOaGxiMU1SYi9ZVGZHeWY2?=
 =?utf-8?B?UHhwUWNoQ0crOWxtQ2VDL1k0dStUZ2xEa3VOSmU0b2tDYVRzMWI3ajdKL0Nm?=
 =?utf-8?Q?BBSdUD6wHm2//UUVj31PeR/LA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9989ba-806b-4176-e2af-08db7e2bf976
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 14:19:13.7009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HbCOkw/VRF+AvyZ1b1LuvYtfocvKOCHr4NzB9SyM8327tDBeQ2iMg+dR6sd8aO/sG6C8alhsZMkfZFNNAeB+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBGcm9tOiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNhbm9uaWNhbC5jb20+DQo+IC4u
Lg0KPiA+ID4gPiBTb21lICJsc3BjaSIgb3V0cHV0IG1heSBhbHNvIGJlIHVzZWZ1bC4NCj4gPiA+
DQo+ID4gPiBsc3BjaSBjYW4gYmUgZm91bmQgaW4gWzFdOg0KPiA+ID4NCj4gPiA+IFsxXSBodHRw
czovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNzQ1Mw0KPiA+DQo+ID4g
QSBnZW50bGUgcGluZy4uLg0KPiANCj4gQW5vdGhlciBnZW50bGUgcGluZy4uLg0KDQpUaGUgc2Ft
ZSBpc3N1ZSB3YXMgYWxzbyByZXBvcnRlZCByZWNlbnRseSBieSBLb2JhIEtvOg0KICAgIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWVkYWMvQ0FKQi1YK1h0ZkJtMGE0YnR0Nk5UOXJ2ZHJ4
RVROTE5NVlEzRz11NTEzTmg4Ukt3ald3QG1haWwuZ21haWwuY29tL1QvI3QNCg0KVGhlIHJvb3Qg
Y2F1c2Ugb2YgdGhpcyBpc3N1ZSB3YXMgdGhhdCB0aGUgYWJzZW50IG1lbW9yeSBjb250cm9sbGVy
cyBzdGlsbCANCmFwcGVhcmVkIGFzIFBDSWUgZGV2aWNlcyB0aGF0IGZvb2xlZCB0aGUgaTEwbm1f
ZWRhYyBkcml2ZXIuDQoNCkNvdWxkIHlvdSBwbGVhc2UgdmVyaWZ5IHRoZSBuZXcgZml4IHBhdGNo
IGJlbG93IG9uIHlvdXIgbWFjaGluZQ0KYW5kIGZlZWRiYWNrIG9uIHRoZSB0ZXN0aW5nIHJlc3Vs
dHM/IFRoYW5rcyENCiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1lZGFjLzIwMjMw
NzA2MTM0MjE2LjM3MDQ0LTEtcWl1eHUuemh1b0BpbnRlbC5jb20vVC8jdQ0KDQotIFFpdXh1DQo=
