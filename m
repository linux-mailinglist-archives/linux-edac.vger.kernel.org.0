Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EEB65C87D
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jan 2023 21:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbjACUyx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Jan 2023 15:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbjACUyv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Jan 2023 15:54:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFEE1409E;
        Tue,  3 Jan 2023 12:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672779289; x=1704315289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IE1x7UOGrXMG2bolgy9UCo+SKWzC6I3gHPEppiSDm2s=;
  b=Xw2XKzmgeRsu/Paeq4sPC4i2C1UPR9w3FYqwQcn8HUkPJmtZcPYnXzia
   KDqZKo+7XlkvDZh+E4nlKarKIbMtHyk5ft9fMn/YQ/baM5GuSPQ4DbAhh
   miN/Pfh2jOQVXUmRipWad9OPJ7ARBc/z8XbYy3uRjiTBaM6Q5lXQ+afOE
   VJuxzG6SsAaKVqA6xFZ3woR+ENTtHFNmCYRzXPzSaPknIgrWs7sCzjhSz
   kNB8IC82cE52mR8MhKZgF7ooD2r45ElOjTE/9d4h5tDxfETuF/toPAUzg
   fZ9YOBQ6Svl/bE76P5izAROM9993ogPMaxVjkkav27D82dCKXZTileCaq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="321824443"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="321824443"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 12:54:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="656890011"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="656890011"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jan 2023 12:54:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 12:54:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 12:54:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 12:54:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGEfk5BhdQRC53go2ebPwAlysbpt3OaCI7TcKlpUb88T8zamSGcY8p5ZzWvA2OUZfqQEiIwBiPeHgW7oIn3b8zKdCk+t2fHbQHRCAnQnX6BKyx5Ei3bclu/9OzuCrUMLLZPGP09gV2QBvSz2MUPPwVdFIXF2TtumlnmYBox8T5dDU6tqYOPLqs5ogylH6IqEiT23SQj5IGw+HCZ13w7PepGrawY9W13/QtoceiB3U4JI6cTgm/oAZonjtShMv27Edfcor2we8mCSSD5fhH1ZfO56t2cTlY9klpuT3q1nOhjJrc857pBjPiaC72k8NqZH+ktc3zqh+LUUu4PsVN0WOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE1x7UOGrXMG2bolgy9UCo+SKWzC6I3gHPEppiSDm2s=;
 b=B7sEJ4oXOsI1FXk3RKNXI65LY77FKjZf2U485OHyc4y3pSOpfa93lBPldK6+VGXB3Hi4Cd5sT+oia+jCW69jqBFKsZu1GZyoZNahf3nhjKMOjENHe0aE4Y7Dd+iLV+xVSRrltWhLa4qV0LnJ6+CjVMUFtVPZ9NUV/2/03XCOTmPuicQAuK1yk9A+wCliCzEKxSkHcbnCWIXjP/WFZzZJV/8dCJB8QZc50Fpsw/VeifujyZDJZaWZ7mJ7uTe6vnZlZtfJRQbQqfjX8dKt5iM2GDDO9VuucxBHpOfrylyM6v+pusYOuyqzeujT73veAVWifDJ+j3pTOevuHwkihgsuIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB6901.namprd11.prod.outlook.com (2603:10b6:510:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 20:54:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 20:54:47 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v6 2/4] x86/mce: Remove __mcheck_cpu_init_early()
Thread-Topic: [PATCH v6 2/4] x86/mce: Remove __mcheck_cpu_init_early()
Thread-Index: AQHZCZlSuzROcqADwEqNTPPKhQw56q6DyCGAgAmOBsA=
Date:   Tue, 3 Jan 2023 20:54:47 +0000
Message-ID: <SJ1PR11MB6083B5EBAE26CD87C7244ACAFCF49@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221206173607.1185907-1-yazen.ghannam@amd.com>
 <20221206173607.1185907-3-yazen.ghannam@amd.com> <Y6yQpWtlnFmL04h6@zn.tnic>
In-Reply-To: <Y6yQpWtlnFmL04h6@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB6901:EE_
x-ms-office365-filtering-correlation-id: 8d3f3fb8-cfd4-4440-0ef1-08daedccbfb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gt9Mqzt9fy8L/+N6kvAY6kJpaui7YwhVnC7enjXA0g00hUD2PIQBnL9H/1QMzh7YG1FH8yO1GSyC4NFL5yM0dlUDHZc5nHp/P2aZfty8Qp6VT6TCLnpvaLzsAai6C3c2bSmv30SoPLTwz+XNjjvfRR7lVVDi5Wq6doNw5BhGodPD92X48R/c39o2jQ6zTZ2aprL3mCmudj5KEuZEsHxkMNlhy0ApATOKej0SpQ1gA16s69LJk1WwHdtCasEnKjE1uC/yuL/hrC7PiiT9YoDTfUqXJuS1V89M1PLHm/9jCTz0hEgI3EWCIG4XOA78vv2a8+SPtoR5ZP92bpieB0zAy3HGBXSw2LrVza0rr5NYHwXDDOBBaxc4+vGdUJa5IZXuuOdbIpN8XIy6bGtihZ0SlAawzOEOoW2iywSydFS65B2ShlWfWDkHPE/MdCUEKINiAaNmgqA8rTYAtUw8aowc+BXnzvYch5Z3HFuixWuAYkYyKg5OUFfB+3eMG6m33DCT0tjxBBtro+L1IuQvJwpmct4UpDHCNH85D8ipQuJ3NADzXK3gpQ4xpU5DXjCDl1hT+MVV+ioImzkqQSLTldlhXOAcGFpttsvuPmnAy3k0JPdk4YSh6oAyRVzzkMAy6u07JrplaLe3bSY4bRLPCuEHQa8dWvdBfJn7+/9qg/R8VGx3MA8upU4DHq1pjm7S9mv7s8JMsNBfa1t2bPkMDjXnYlkyih7V73KjEoccrYqwUsg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(83380400001)(86362001)(82960400001)(38100700002)(2906002)(38070700005)(52536014)(122000001)(5660300002)(8936002)(41300700001)(6506007)(478600001)(26005)(64756008)(186003)(9686003)(8676002)(316002)(66446008)(4326008)(66476007)(66946007)(76116006)(71200400001)(110136005)(54906003)(7696005)(66556008)(55016003)(33656002)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUVVUUY5cWZhbVZHTEhBTGwxSEloVmhPa3N6MVVTeWFEeVk2c3VraG9ZVndp?=
 =?utf-8?B?MURuOTZPS0IvWkpRdUNTUFB0dkxtdWRKN2EycUU3akJGREJUTVU2NThGZ2JJ?=
 =?utf-8?B?UGw0ZDRzcUs5N2d4dHlDOUp3U1daZjFnMzFTdGZMZUFvWE9pMU1rYi9jR1NZ?=
 =?utf-8?B?R256T2RidU15a1hBa2J0aVpjeGV3TVJKaWljR2hUZGs2N0p5ZlZCRkVtV0Nz?=
 =?utf-8?B?VWRMaXg4bVdPaWd0dFp3TkdGWEM1VjdMTEtKaFdjcTRaaU1mVDhtR3hONU5M?=
 =?utf-8?B?K2d0U05PZUU4dnRXbXhhUUkwMmNxT1dCMm1ud0Z1aFFSOW5OMUhQNUZXVzJp?=
 =?utf-8?B?WmREeUI0WDdqL0c1cFpVL1RleUNhZVFGeE9vbW9jVTBWS3JtR3dYWEVjd0JF?=
 =?utf-8?B?VkE5N2JrbGtTL24yUEFMUW5QZ2Z2b21wN3paVzFkdUYzU1NpNVpkYzZnY21m?=
 =?utf-8?B?ZTZ0OURITkNJNFlocFI2ZWtvWlFSMFU5T2ZGSnpGMDhkV0ppUmRhdE9RWnlY?=
 =?utf-8?B?YlhaSlR1c3Uzb29paVU3ZGtzRHorUGpoOG9oeU5CejNvVzl4dnJ0MzFOQ09N?=
 =?utf-8?B?bjIvY21WS3NqV2pNcmJySWJta0lIdEZ6cStvUUd5c2dlMU9pVnJGZ3JzaU10?=
 =?utf-8?B?MGxXaVl1SG1NYThkQkpZWGNXQm1GWldwSmI3clRtUm1lcWVrNE45U1R1MGd3?=
 =?utf-8?B?a3JwMFU3M3Jha3IzRjFwdDI0ZU5PWUI4bkZNZ0twRWRiLzJ6OC9Lb292cjJk?=
 =?utf-8?B?SVlvRlkvaHd4dkxrMkhRSVRuV1NnT1YrY21aRjNGVll1aHYyaHJHVFNMSUZx?=
 =?utf-8?B?d0NkcmFMb2JkZHd0ODZpNzRzR1Q1VDZCeGZUU2dEMmFMcjhLbUEwelR1N1Jp?=
 =?utf-8?B?NUR5ZUdlR0xWckhJc1dsNnZoN1diZFFwY3RvNyt2ak5YSDlJbTQ3OW4rUjUy?=
 =?utf-8?B?MUVqditPSm0vNUV5T3luMlVNeFQzOE14RVhsTDhMTk11MkRTbFR1dVNPREN4?=
 =?utf-8?B?ZG1NWEczK3djOGt0d2tkZkh3enRlZGNGMmorVmg2LzNUOE0ydTJrTlJLSHlC?=
 =?utf-8?B?OUVOd2swbkRBQi9jM0lGMGtYWWxUUStaOGhvSk1DT3hqaGREenYzSU9DbDNx?=
 =?utf-8?B?SzFSbzBZUXB0WGVXNFVtc000YklnQXNiOFMrVENPVHljaUZsRi9KaGFHRDM0?=
 =?utf-8?B?bEhRTUUvL2MySVhTcDF0YkZPazNBWWtIK0krMnJGd1h3bmlRZXMzMWpXUmw5?=
 =?utf-8?B?aVZOb3d5TCtWN3ZnWW5TTys3N1EvbUdsNnNYUFFvb3lXNUdZUWpvcWEzaTlL?=
 =?utf-8?B?UHNRL0JvSEdVSmFVU00yVzdzT3VNbkljcExHa3VRKzBvNk1YekgrQ214Qmdh?=
 =?utf-8?B?bjFmNS9jb3A2OTAzVUFXdFZXdUw1dzk5b0hsSktCSS82U1RVTTgyRzlMMnR1?=
 =?utf-8?B?TEFkcHlaWWc0V1daT0gyYTIwaU02WTFpVi9raDg2L2puMWlLQzhwTDFUZ1ZE?=
 =?utf-8?B?b0M2cCttSmxuNHB4VkhTTndQWVpKcU0weU1Kdjl6Y1FqTTVhZmZ5SzRPTG4w?=
 =?utf-8?B?ZzJ1WjNGWFU5WlNNTnFsSnhUK2pHVkt3ejVNOHZBY2lWUmwzd3RlbVR2bDFX?=
 =?utf-8?B?WFJwK1M1c0MxQU5SQTVxWHYzY2gvcndYajRBTmUyU0ZmMTVXRW5ndi9QR21Z?=
 =?utf-8?B?UDI3d0Y1VUQyTmdkUTQ0S1Q0bklPcTBuSU1rbXlZZy93cUQyN0w2cmJIQjMy?=
 =?utf-8?B?Tkc1czNkQmJ4UzNyNUx0VFBkdkQwdHNNT0UzMEhYVUtzQnE2ZFhHdzlVRktB?=
 =?utf-8?B?RWZUemRETytTTHR3MVFhZHlFenArUCtoM3Z2R3JvYzJ3V1JNSCtkVXZnNWh6?=
 =?utf-8?B?eE1TNEFmTk9oWlZmcGl2YWdHblRjRE9ESHJhUHcveVZlMEhzQUtFenI3TkVM?=
 =?utf-8?B?N0tFQjBaaDg4TFQ4Kzg3UXh1Y0lnekNDcERKU09MRzh2T25OWHUxMHpkMHVL?=
 =?utf-8?B?VmZ0UkttY1NjbEpLbEhZbmc3d3VNdzdScVRTcmxjbmJ2bTA3WjVZSTNwZlJp?=
 =?utf-8?B?RW1yM0Q4UVdJM2Jsc1NjYXdDcEF1bEFLczMyVWpyTFlCVXJLMlhZOUFCNHpJ?=
 =?utf-8?Q?M04CsdKN7kIiOutzZBn/MqqNE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3f3fb8-cfd4-4440-0ef1-08daedccbfb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 20:54:47.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdWNV79JnBlxBuYhZfb50Z07ymy3/5YOuDrr10fCRTsS+lLUSu2fhLnQidCOIM5W8d8EDFh9x5ehfEmhXX9wMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6901
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBZZWFoLCBsb29raW5nIGF0IHRoaXMsIGJlZm9yZSBhbmQgYWZ0ZXIgdGhlIGNoYW5nZSwgd2hh
dCB3ZSBhcmUgYW5kIHdlcmUNCj4gZG9pbmcgaGVyZSBpcyBzaWxseS4gVGhvc2UgZmxhZ3MgYXJl
IGdsb2JhbCBmb3IgdGhlIHdob2xlIHN5c3RlbSBidXQgd2UNCj4gZG8gc2V0IHRoZW0gb24gZWFj
aCBDUFUgLSB1bm5lY2Vzc2FyaWx5LCBvZmMgOy1cIC0gYmVjYXVzZSB3ZSBkb24ndCBoYXZlDQo+
IGEgQlNQIE1DRSBpbml0IGNhbGwuDQo+DQo+IFRoYXQgYWJvdmUgaGFwcGVucyBvbiB0aGUgbWNo
ZWNrX2NwdV9pbml0KCkgcGF0aCB3aGljaCBpcyBwZXItQ1BVLg0KPg0KPiBIb3dldmVyLCBpZiB3
ZSBoYWQgdG8gYmUgcHJlY2lzZSBhbmQgY29ycmVjdCwgdGhpcyBmbGFncyBzZXR1cCBzaG91bGQN
Cj4gaGFwcGVuIGluIGEgZnVuY3Rpb24gY2FsbGVkDQo+DQo+ICAgICAgIG1jaGVja19ic3BfaW5p
dCgpDQo+DQo+IG9yIHNvIHdoaWNoIGdldHMgY2FsbGVkIGF0IHRoZSBlbmQgb2YgaWRlbnRpZnlf
Ym9vdF9jcHUoKSBhbmQgd2hpY2ggZG9lcw0KPiBhbGwgdGhlICpvbmNlKiBhY3Rpb25zIHRoZXJl
IGxpa2UgYWxsb2NhdGUgdGhlIGdlbiBwb29sLCBydW4gdGhlIHF1aXJrcw0KPiB3aGljaCBuZWVk
IHRvIHJ1biBvbmx5IG9uY2Ugb24gdGhlIEJTUCBhbmQgc28gb24uDQo+DQo+IFNvIHRoYXQgd2Ug
ZG9uJ3QgaGF2ZSB0byBkbyB1bm5lY2Vzc2FyeSB3b3JrIG9uIGV2ZXJ5IENQVS4NCj4NCj4gVG9u
eSwgdGhvdWdodHM/DQo+DQo+IEkgdGhpbmsgd2Ugc2hvdWxkIHN0YXJ0IHdvcmtpbmcgdG93YXJk
cyB0aGlzIC0gZG9lc24ndCBoYXZlIHRvIGJlIGRvbmUNCj4gaW1tZWRpYXRlbHkgYnV0IEkgdGhp
bmsgYSBwcm9wZXIgc2VwYXJhdGlvbiBvZiB3aGF0IHJ1bnMgd2hlcmUgLSBvbmNlDQo+IG9uIHRo
ZSBCU1Agb3Igb24gZXZlcnkgQ1BVIC0gaXMgbmVlZGVkIGhlcmUuIFVubGVzcyBJJ20gbWlzc2lu
ZyBhbg0KPiBpbXBvcnRhbnQgYW5nbGUsIHdoaWNoIGlzIGVudGlyZWx5IHBvc3NpYmxlLg0KDQpD
bGVhbnVwIHNvdW5kcyBnb29kLiBCdXQgZG8gd2UgbmVlZCBhIG5ldyBtY2hlY2tfYnNwX2luaXQo
KSBmdW5jdGlvbj8NCg0KQ2FuIHRoZSAib25seSBvbmNlIiBzdHVmZiBiZSBkb25lIGZyb20gbWNo
ZWNrX2luaXQoKT8gT3IgZG9lcyBpdCByZWx5IG9uDQp0aGluZ3MgdGhhdCBhcmVuJ3Qgc2V0IHVw
IHRoYXQgZWFybHk/DQoNCi1Ub255DQo=
