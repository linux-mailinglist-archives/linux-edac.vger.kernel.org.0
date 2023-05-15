Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9208D703E1C
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245213AbjEOUHc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245184AbjEOUHU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 16:07:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6812E11B59
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684181233; x=1715717233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ucXB+jh4iseMDqSv2f2xFcYj0CL2Zm85r9cVgEhi6sk=;
  b=eBXsjRgpr8kcJu310cU16hyrJM3nnURG1RwLwli1geO1a+kzll7wo0Vs
   AWk6zSDqP9lKrFuW+ZeoEJ/lldRV0Lu5gsCexzy3BNK/olMTQUaERKAal
   1ghXYaz1QEmKOfPUXeWCmQbo0r+q+ORgU5Oup2uoEdl+gtR1JcoHiwF5k
   +7jMzhYjTaDv5hpqqowiv3n3kgeGR7rsFqSYj9Qp0oKgutJHCEvY9fmI9
   7O1hW+Ki/d6eX0LE01L33O/Jcu2+0w/hnKpryAY6tgkJ52krkeJv4cukN
   zikT5/gOOCl+vsgWdMxTtK6oVbtebjeN/8hte8HnKOnPAEuHPhSnEpFj7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="379467091"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="379467091"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 13:07:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731748308"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="731748308"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 15 May 2023 13:07:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 13:07:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 13:07:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 13:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l92lDEq50nxtFchQpSDSugrzD6zCPdx1+KOtSwYg6joiOhTm9mhtVt4HTC4QuEALwy8cLjVTLWMvi93m3VU/2ywEk86Ujg+3LYfXlyOkcRpA2KcIop2A7b0r2dAd/QLJ+ugjXJTdJKBGL4ffmevo7Knd8qrO166OBepfyMlPV0Khy5obuAMUWPX6XqsZigqwdiR0RpSQBL74ERicWnDoxkU7kmkdZPTtfhx7Daz/OHyNCHfuUQeNrArMsnMyyODKbdXvYRDXYKhlC3eYh0hKvmIzo5umHlCm02Yu5zpF0TbzmlFUSceAKAjm7y65Bz5SEBuap1XEKdASjqJ1OttL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucXB+jh4iseMDqSv2f2xFcYj0CL2Zm85r9cVgEhi6sk=;
 b=EB7to9DRe2OT7+74FNPG1fWfz7SvvXaPgoH7zcVw3tJy5R+mW6x8vZjpF8YYsC8xTpkdsxWGVqyzCk7Xx8F9C3rdsJ2pwKYrf8LisVbidmx1wudsQW7tiucEofroIR7eJ547mMjgFrsq9LlH3jCrqUKaOaQX1uBWKGCkRrEMAwjB8Mqo9g+HhoOLLNLtTrGzO1vT96/+rPx3r1b067c0nKseBpq/ooVTuw4j3Ii2DWkYFcgE17KdXZc8bbM9PVa4lv76mv3Cf7qBgF5sWhtphsj3UCDAbs4olpoOU09Y8FyUkmiMoNTrkfElfMs1mdqfZqkSWg6tKph5DrjL8J258Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7306.namprd11.prod.outlook.com (2603:10b6:208:438::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:07:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Mon, 15 May 2023
 20:07:10 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7CAABk1AIAACA9ggAAMfoCAAALmcA==
Date:   Mon, 15 May 2023 20:07:10 +0000
Message-ID: <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
In-Reply-To: <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7306:EE_
x-ms-office365-filtering-correlation-id: 6655f526-507a-4da0-b6f0-08db557ff7a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlhQl4M+cynjDZZYAiDtGujrWpRkSNWoy2ObxZMBXbSJvaBgk1klm+QAni70alHEbZjo1txEAAEOiVRQZcN2Hn1O7sExNSVbga9mmIFAUYbCFKGDP62IFpGbyOmy5WlAFauIDkDc0331g9cHnvbUkz6BqmJIrSAW8xecrjaSAfj//zrTPtu44Tv/EvfqMU0PKscF5Uk15q14xogkrO/e84fKcxQALGImwkpBMQ3mNlY5+f3gwYh2vQ9bACHaz+i+uUj5XI8EUXHPPP56bDul6nKtDXDPJN658YutnzpLQuzm5vV/7CEVAp1DclYGBB9YBwHdu7WB+BJUpiM6Bo12WUUA8mTvIcidjPdi5I5Lca/jlAk+wz9edaSbPDs3DVkTzpHPB9iQqy1Kot9ZPfoVfwwotOOp8AvNAyot/Q9M/zM/vpnvv8mbe5GhLQFj2dgXdtc1Nnu6mrTp44NxR9qgxXo5UCt4C/5+ZQ9OrHHvP1AyNzHT+Ag8k58Zb41fXoctU1SfLXKMhuLvzQPjlvTzb1Wb6HQYyHVy6p85Dq0BwJ0mSKUJlyhfnNBIsniCTYgNphGEz8pw4gqudEl4LSoZxMnvxhj3+tloeIffUaanZfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(2906002)(38070700005)(38100700002)(316002)(52536014)(41300700001)(122000001)(5660300002)(8676002)(8936002)(33656002)(86362001)(55016003)(71200400001)(478600001)(6506007)(26005)(9686003)(186003)(966005)(7696005)(66946007)(6916009)(4326008)(76116006)(64756008)(66446008)(82960400001)(66556008)(66476007)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTBtN09JK0thVGV3VXQ3Z1IvYXdmRHpHY3MxRkg2WkJGYmtFNkZ4MWlPVm0x?=
 =?utf-8?B?dG1SYVF6eEx5bFIzT1FWR0ZZUVdxT21aN1ArT0FUT1BDdnVUdm1NakRiN2Qy?=
 =?utf-8?B?SjVHenc5VDh1RkRRYWlvdXRkWlI3bURZeUdLK2xsMXFjNmU4U09EQ0pLOEZr?=
 =?utf-8?B?eDNyRHoydHF2andPaDVMazV0MGJ5NDViNlNCWm54VWlwQVA1d0NSL1lyRlZ2?=
 =?utf-8?B?T3hTaTJnMnR4SDNicktwNjYzclBNM1RKMVAwMktYRzhjY3g0NGduWE10M3dG?=
 =?utf-8?B?RisxTUd3dWh4WlVvVFRFL1djVU4rUHJyUHBhdVY2QjBWZ0dxM0JCcGFDRUZ0?=
 =?utf-8?B?clNpdEM4b1hmR1FRZmtiQUpoNmxEVlJtdy9MRU1QZEkvOWM4M2p1MXNRdGNx?=
 =?utf-8?B?K05VZGNnS3BXYTNBRHo5UGViOXVENTQybmhTWVhTakdSL1NzbjYyeFJHTHVR?=
 =?utf-8?B?NHB1aVBTV3NiWFJMZDVNVjFNSnVsOGQzV3hTN2hOYkR5dktsUjNTN3JGOHRZ?=
 =?utf-8?B?Q1dNRWZkcHVTTUk0L2gxS2l5R2pGOGhMeitkTlZxWmc1MVZpNzFvTTZJMjFB?=
 =?utf-8?B?eldLUXhqR1Z6bnhEQzBEQmpGVkd3WmRZdXFUbk9CeWxWenZ5alBQWXJjeXM4?=
 =?utf-8?B?bm1jaGVDMWJsTlVYN0s3K3BpNE9SL28xeEpaSUdTNHd5cEFQN2JBWXdXbmZ4?=
 =?utf-8?B?Y1JPR09nUU0zZ0xGRUw4YlN0MENiZzNrUlZjM0JIZ1hVd1Z0NzJKbEx1Nm5I?=
 =?utf-8?B?UlJZUEJ3UXUxcTVvemZMOW5YRCtmSGIvUGlXSjYyWXFMZlFrcmVISFoySE1C?=
 =?utf-8?B?SjFGdEs1b3dKajNORzYxaUw0ek1Ga2lzZG1uTkkrOWNZT2gxYWNqUXJKT3Zr?=
 =?utf-8?B?TXRoSWhIMCszdVF0b0hIVkk5T1l6QWQ1cEF4b2UrSkZjWWVnSTFOSHZOMHhm?=
 =?utf-8?B?VlpJcVY3djJ2MG5LQ0ZQbzhTNUw5aFBmZ2poTi9wZkExUDAwZlBRMUdkZFMz?=
 =?utf-8?B?a2xzQStZRmk4YUVVYURWMnJwYlp6d242bExjUVozb1ZyTDRhamFkaW5nYXdD?=
 =?utf-8?B?c3E0N2RoT3NRN3F6WkplV3pSVVRWSFYyYk1wdzU5eTc4cHBWdWFPNDBCY1JC?=
 =?utf-8?B?bnRudENXUk9sZmhXamFlMkladlkzTHlOM0tSUFQvNXEzQm9UdERyc3RlQ3FY?=
 =?utf-8?B?cm5Wa0gyVTZkL0F6RXJ2Y2dZMDlNYjhNSTVkYWJDZjNkNG9mVElkbE1BUGJ0?=
 =?utf-8?B?K1RWRWxyNktSZkFHTStLZHI0MzZSY3V5L1NDY0lITVFPMzZJZ3NWRDJVd1lO?=
 =?utf-8?B?OW1KdEp2MkdtNnJxQlEydVQ5MTVuRDBHVW5raVg2STJIWThpcHNuQloxMGtY?=
 =?utf-8?B?WXp6ZnpDTGNEcWJsdWxyZUFjQ0NOOTRwcXdZWTdJTlNBenZ6bzFCZ3RwZVJN?=
 =?utf-8?B?UXRFR1V2WUtrM3YzaVJiNVUzVmxSL2o5UUVWRWdKK2ZwcnVsTUY5RnVDb1RM?=
 =?utf-8?B?ME1ad2xTZUJ6dTZZNm4zSVZ0RHJLV0xqMDY0RWo2aTR5SUpKZlRHSmwwYlNG?=
 =?utf-8?B?MXR1ckJPLy9EbnFrcnY2emdqRHB1bndBOVBaMy82ejcyRkhHTkVqZWx0eWhq?=
 =?utf-8?B?SnlJa1pHTDYvb3ZOTzR6a3VGZlZxaGo1Sk5mSVZ5ZkJnL25TTUtFcFRxNWQ0?=
 =?utf-8?B?YU5VbHBmamVyOGJld0NQb3RLTkNUa0ZHSFJWbzZUUVhpS0plbnJ5N09NRFJw?=
 =?utf-8?B?emxPek5yOTBlZTl6QWZlRUNpdHkyNFJFTWd4bktEWWhRSjZYWTJERHhVeDU5?=
 =?utf-8?B?Qm1ldzRBbzFna3NDbWZpVVI2VmhibS8yQ2ZYbnpvL2p0ckluUlRqeTQxU3Fm?=
 =?utf-8?B?bkFDbXB1MkRVOGwzaUJFRDFUck40bFlGY090cnVCUkFJemhkemJuRlBQQTFD?=
 =?utf-8?B?VkwwTmN1U3JPbTQ1bzQ5RTBSektsRHlaR050V2M5SllGQmJRN0ZnNHRDbEYx?=
 =?utf-8?B?bmM3QVBMYXJmSEd3ZGtUTG5Ud3ZlK1h0Yjc0WEVoWDg3YTZ4NVZTczNnVGE4?=
 =?utf-8?B?VEQvQWY4NktLeFM2TnJQbEppdVdxNHZIVG9HeXI5QUFzUlYwekNJdkhKdVJS?=
 =?utf-8?Q?t5M8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6655f526-507a-4da0-b6f0-08db557ff7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:07:10.6223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61BjF1OFnbddmnpEAUnZFen6jjjJkM9dA22zLjfI5Y0d59WyJ6GZGxaj9394wtDuJf/A96y2ijSh3HirZ5D6MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7306
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

PiBTbyB0aGlzIHVuY29uZGl0aW9uYWwgc2VyaWFsaXphdGlvbiBpcyBqdXN0IGdyb3NzLiAgVGhp
cyBpcyBhIHBlci1jcHUNCj4gdGltZXIgZ3JhYmJpbmcgYSBnbG9iYWwgbG9jay4gSXQgaXMgZ29p
bmcgdG8gbWFrZSB1bnJlbGF0ZWQgdGhyZWFkcyBhbGwNCj4gd2FpdCBvbiBhIHNpbmdsZSBsb2Nr
IHdoaWxlIHBvbGxpbmcsIGZvciBub3RoaW5nLg0KPg0KPiBPbiBhIGh1Z2UgYm94IHdpdGggZ2F6
aWxsaW9uIGNvcmVzIGFuZCB3aGVuIHRoZSB0aW1lcnMgZmlyZSBqdXN0IGF0IHRoZQ0KPiByaWdo
dCB0aW1lLCB0aGV5J3JlIGFsbCBnb2luZyB0byBoaXQgdGhhdCBsb2NrIHJlYWwgaGFyZC4NCg0K
TGludXggZG9lcyB0cnkgdG8gYXZvaWQgYWxsIHRoZSBDUFVzIHRha2luZyB0aGUgcG9sbGluZyBp
bnRlcnJ1cHQgYXQgdGhlDQpzYW1lIHRpbWUuIFNlZSBteSBlYXJsaWVyIGUtbWFpbDoNCg0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1pGMThrZFdDV0txRmMyM3BAYWdsdWNrLWRlc2szLnNj
LmludGVsLmNvbS8NCg0KYnV0IHRoZXJlIGFyZSBvZnRlbiBtb3JlIENQVXMgdGhhbiBIWiB0aWNr
cyB0byBzcHJlYWQgdGhpbmdzIG91dC4gU28gc3RpbGwNCmdldCBhIGZldyBjb2xsaXNpb25zLg0K
DQo+IFRoZXJlIGhhcyB0byBiZSBhIGJldHRlciB3YXkuLi4NCg0KT3B0aW9uczoNCjEpIERpdmlk
ZSB1cCB0aGUgbG9jay4NCgkxYSkgT25lIGxvY2sgcGVyIG1hY2hpbmUgY2hlY2sgYmFuaw0KCTFi
KSBPbmUgbG9jayBwZXIgc29ja2V0DQoJMWMpIENvbWJvIG9mIDFhICYgMWINCjIpIEVudW1lcmF0
ZSB0aGUgYmFuayBzaGFyaW5nIHdpdGggYSBiaWcgdGFibGUgcGVyIENQVSBtb2RlbCBudW1iZXIN
CglbTm8sIHdlIHJlYWxseSBkb24ndCB3YW50IHRvIGRvIHRoYXQhXQ0KMykgQWxsb3cgbXVsdGlw
bGUgQ1BVcyB0byByZWFkIHRoZSBzYW1lIGVycm9yLiBBZGQgYSBmaWx0ZXIgdG8gc3VwcHJlc3Mg
ZHVwbGljYXRlcyBpbiB0aGUgbG9nZ2luZyBwYXRoLg0KDQo+IEFsc28sIGZyb20gbXkgcHJldmlv
dXMgbWFpbDogSXMgQ01DSSBkaXNhYmxlZCBhIHZhbGlkIHVzZSBjYXNlIG9yIGlzDQo+IHRoaXMg
c29tZW9uZSBkb2luZyB0ZXN0aW5nPw0KDQpJIGRpc2FibGVkIENNQ0kgZm9yIGRlYnVnZ2luZyBy
ZWFzb25zLiBBcmlzdGV1IG5lZWRzIHRvIGNvbW1lbnQgb24NCmhpcyB1c2UgY2FzZS4NCg0KLVRv
bnkNCg0K
