Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2940A6F1FEC
	for <lists+linux-edac@lfdr.de>; Fri, 28 Apr 2023 23:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345675AbjD1VBh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Apr 2023 17:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjD1VBg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Apr 2023 17:01:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699A7F3
        for <linux-edac@vger.kernel.org>; Fri, 28 Apr 2023 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682715695; x=1714251695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y7l27DYuUUmS40ZkAaJ4WTI/vSVpYUR/Xr3dLE2UePA=;
  b=hjDS8dyyj6NWhJdthXIRhfRcsA6hzXg9OZZX7rQOEKyBILOs5VzTwMIl
   nWlRh4uaBrNyapAFOEyfHmjSGEqmj1hdz8VYTQbZrqDknzr2SWJVDm5th
   7ysyJ/SoXNyzYThZrp6MksKGA3JKCyIx76luYxQMzyLFM54a0TJHv6wyG
   XORf0A5DBrid1GCShDQZzYAJNq1swTSbA5vYG/srfuwtf3FCUuPcfgRM3
   9oZs8yVQ6ub9oce1fV7XNLjg21xUYF9Rs/qP3u69HOQPZasxri6TMUR3q
   AQbIDKZO+GogLSmxvCHaPOJeqb14qXcSzYngqTps/omLJkNSnsTzbyPFf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="349888352"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="349888352"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 14:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="694941449"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="694941449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2023 14:01:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 14:01:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 14:01:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 14:01:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 14:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwEkYn0sOOkyQfDm+orG3uzNbtuNAvVwWbVTqxyZT/RilgiYFPFR1lXvjqdIEoAlUtblV/1x67QHaKVvd1QmA/qUrFWtropkq/GVpeZhCEgG/8LcviJLgykPX8iMNDvfWaKGrYdUs0gXWu7KR3eLuyi24530mRTfHgTaFbPP4hSF8hXpieuvxG/U66dqIlNqSf09CLr4FR7nBo9uzmOSiWK+2V4fyv/8gzckYDpk81+NxpBpT6ihhR6Fx3exuq1rZrRgUmA3wUPgMTW/fhZhRt4sThsapmOy4NJ09Fk12L+XIobzBnCzSo8lfXpoXWfPDCl5zuO6drU7PL5QmHsxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7l27DYuUUmS40ZkAaJ4WTI/vSVpYUR/Xr3dLE2UePA=;
 b=EkNLLRphnVe7PiJ4N/560vZKltjrviWzF/Cc36loj7zqjNXWWw4L50WvT6VfRuck2ibymXjgprcmTKyFWqsiygw1cW+7bxxUO76rHjy9lawJsU3jsQQLErCoYPTWA2Q0Cv5DO+IRw0vHLrCeqZJMzuhZz1P1EYtaTgHczF2MMHuO0LwGZ5KsssH26txjGmEmUg2g24asKENHqjrDFVn65KPkbHCCZyK1rdvR5ENdqLXNw+hkIsMcIp8WetjSthjDA+YMP3ZHAP9CdXAsBue1QfvDkLxE7hWdzxjg2egY8rgSWGqne8O8CQvQGlEZMJr2uL7v24TrDdscWQMnrZshNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 21:01:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 21:01:30 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Alexander Wetzel <alexander@wetzel-home.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: ECC DDR5 ram with i9-12950HX
Thread-Topic: ECC DDR5 ram with i9-12950HX
Thread-Index: AQHZeg60HXS+4KrF9Uy3toV9BW+cGa9BMkRA
Date:   Fri, 28 Apr 2023 21:01:30 +0000
Message-ID: <SJ1PR11MB60839876CAE8D91FBC9D28BCFC6B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <b14a8fd2-4c11-1d76-f27d-e9d10c94ca9d@wetzel-home.de>
 <ZEvsamYDRi7wZr/b@agluck-desk3.sc.intel.com>
 <d33f0103-b281-55c5-42fc-4d6eea215763@wetzel-home.de>
In-Reply-To: <d33f0103-b281-55c5-42fc-4d6eea215763@wetzel-home.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7852:EE_
x-ms-office365-filtering-correlation-id: 9c0f11fd-080b-41cc-5959-08db482bbd96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0BpNVpfvI9Z1HjQaVg5aSgXXcjB+NZeoCCKPThfcjvcaKaeS3w/nineK/ijb5+K1UCMR113H8mHgyPaCAPxxdXYX+FPi7yRke+wmP27WIS8XleqjumJpDtEy1yORNWG05cjtUIItQmt3/9zuCXnzow69/xxqPekPeoprjA5i/Zb1ou+97Dl5hfj11sdpb6zvES3ZGti97RCLPdPWK2a6GZX25LZn1/brTMm1PvftmUm8Q7pmCT3FZrP21EONI8vMsWPAPLeAUhXts3fXy4XBLWUvlwJicICNJAqNg0AtxQe8l7tJd55HKCugFJckY3IDHZqzHtO4OUGSAFjkh7Yj+RshFjBPYEIc1AwJvVNyf0YzxnZXSjaHY7toBU8DcwWZsvaFCiyBTSSGK9eV+Jx9HeeamQHeALh3g5kf0R8WQG9bGhS9RCZT7AqxIm2raBq9pvbhXK9aum4JaH6MkH1maYXV4mSZuj/W6Ocz5GD8zQN/Er08SD6zGwvLYWymXptTU2/jUb2OqtZ5HVegmzbHkkEnXygMTEzb3aY2E4mg/FLkgZ659xhUtPKiogdVn9aEO/DZ4zPRDbI/za5gE2g50XavaY6ZyM9VBfj840wLXJu/tHwDhX97uA3e4PskWeCV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(86362001)(38070700005)(8676002)(9686003)(6506007)(5660300002)(122000001)(8936002)(52536014)(2906002)(82960400001)(38100700002)(76116006)(66946007)(6916009)(66556008)(316002)(64756008)(66446008)(66476007)(186003)(26005)(4326008)(478600001)(7696005)(55016003)(33656002)(41300700001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWU2TW5Qa2c2cGs4anZ1YUpmTnVuK1NldHV5ZWlzL3RVMW1lbEx4dm9XU1la?=
 =?utf-8?B?eUUxelR5cGZhdnFDeFBuYWVJSUtrZHVEdnRXcC9ySVowUExxOEtuRVNPVVJW?=
 =?utf-8?B?MlRzRGZhMlIwYWpGMzVaQ1lVV0xNbWQ4SkJoVFZBOWpWZmJEc3JzL0xKM3d6?=
 =?utf-8?B?UVdzejllZjROVnJaTG9mQk1lUjBvUExxSjNrcThCYkllVXJGbi9uazFQZEVV?=
 =?utf-8?B?S3E2dlJpNWxBQmd5NXhzSytaYWdURkoxNW9tbW43YWExRFdPajVFSDZlZHFX?=
 =?utf-8?B?R2h6Q1Y2Wk1oUnE2Z2xrNy9lMG1UWWtDUGZpMW1COVNNNFdjcEUrUlQ3WW5F?=
 =?utf-8?B?ZDRFV00rdllydVlmRm5JYk8xVXhidkR6Vlp6YmNjclJiVTltR2M5MytyaTk4?=
 =?utf-8?B?WFRCT01DL0V6NDFaeTBGY05XWCs5b3NZRjcrVEhzK0dZYmVIQnRBQWM2eVRr?=
 =?utf-8?B?WDh1SWZaTER1MW5wdnNxWFNqV01ENHdFamVNKzlTMnV0THhrTmlMc0h5QTBV?=
 =?utf-8?B?VCswUWFDK0FuQzhsR29vOGFBQ2VwK0JVY3dqd1g4aWlUWTFkd0R4U0lCc01y?=
 =?utf-8?B?SDBZZGtpOFAyeTI2S2czY0E4ZzF1SE9lL0hhUndqYlBCVmlMa2JVY2V0OUNR?=
 =?utf-8?B?SUJlUDRmeEJEaDhVRjVCdExXR2ljc0JqL1FFcGVYUG4vRmtHQUJrSk9KS3Vv?=
 =?utf-8?B?WW9yRnpwdk11TitBbzBOTDhBNktRYURhSFlnSUlZcXBLb21EQTI2Sms3S2tO?=
 =?utf-8?B?QStNc2VCNk03UzZLUkRmR1ZCY2JjZlBsK0s4WU84YmVGS0JVMTZTaVhLZkFI?=
 =?utf-8?B?VDkzL1cyYksxOWcySCtiWUpTRURBWlJJUi83Nml2SlJVWnFNM0lHUWk1TTZp?=
 =?utf-8?B?UEV0V2lZbzJGckM4L0JwUVBvOExrQ0lzbVpucm0vZEhKenV4QXFBRWJUUHEx?=
 =?utf-8?B?TXpxLzlDOHRjdXFuSDVKYlVBaFRnUm5tbGlRR040VmQrV00rQU5qYXZtTVZ3?=
 =?utf-8?B?OFlXOEo5VzJuakYwdWVoRDFaN0xNSlpndEQ1Q09QWEI1aFR0RTdMYVlOdG5s?=
 =?utf-8?B?aTI0WmRQN2pWT3BBTVFycVplUzNNdjBqK24rZ0RVVnRlTHd6VU91QUx3bW1x?=
 =?utf-8?B?eWtIQ2pJUVE2YTZUbmtsdGk1SkxwUFJreFl5ZUt3Skd4c0RlS2hMM2plc1Ba?=
 =?utf-8?B?QzRUNUdXdmdXNisvaTdWdFI4eTJUa3V3UWU3Zmo3Tmt5U3dpZ01qbUU0MmV4?=
 =?utf-8?B?S2FuSjRVRHRBOCtaODJxd1gzdlN5VndFcGVPZGR1OWlmbGw2QnVYQ0FoTUNa?=
 =?utf-8?B?RVE5NHlLQ3l2NVZuODRPVDRWQkhXcXZiK1BIL0x1ZFNVTURhN2pObHBvYi84?=
 =?utf-8?B?TmhGN1duNHpocFJGbU9VSWtxSlhTdHZqaktkZkVhY2NWV1hKUTczaXJjVzZk?=
 =?utf-8?B?Q0NJOGhoV25RODJkOW9uT2wxazZtU3NHVXNsbTF5TUR2cFl6eUNTL1ZaSE9r?=
 =?utf-8?B?MG1BbnJRamlWSVNDSkNLVDdFTTJITVRQV3pOaUV3bENndXFrbWVRT2s2dVk3?=
 =?utf-8?B?Qm03VWJXdHFSa2xTN0gxRTFoVGdORmZvVHpWN0U0TS9LcVI5RlZFRTBzU2pB?=
 =?utf-8?B?Qlg5SHpxLzFUSWc4WTArbHo4bTI3N3plU3NEZ2pPcy9laFFPM05PNmNqV09Q?=
 =?utf-8?B?dUxDSUwxRTR5VHE2QitjSWFSSTk1azVyY2RBaXNueFNrS1JkMUs0T1RTdk5E?=
 =?utf-8?B?SUplYmh2RFE1Zmo2Q3VKQ0k5L2RPRzdGTnNCNkIrZU10WEpWZ1k5aDJvZUNr?=
 =?utf-8?B?QXFETzlHeWkzTWtTRjdTQ2pLS1ZJaDd2VTYwL1NYUmNIMEd2cFJlTE45NDVJ?=
 =?utf-8?B?Tm5yQzNRUnZDaGh6NGYrcjNQL2RsWTNwanl5eThZeGh3cWV6WjF3eG42Wndq?=
 =?utf-8?B?L0g3OFFXK3ZId1JTU0M2OWdjNXFYTy9wN0RhSTdNVFRPTnYyZmNPSEdQY2dL?=
 =?utf-8?B?bEZuUk00MWtwREVZVXh2UTZ0Zld4SEZQYTlFbGZZN2t0cUpKT0tRQW5MTDdj?=
 =?utf-8?B?M0pINkZvZUhpVkMxNnB6TVVYNU5HdTEwS3F6b21ZYWV4L0hXY0lJTXFPZ1hY?=
 =?utf-8?Q?RZH8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0f11fd-080b-41cc-5959-08db482bbd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 21:01:30.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FJ896L8rd+5WZe/kENaPBYvzeLUV4QSjvXId8N+MDOE5CmAVTWj3qXedpuwMvHKYPQ2lrQDx/cmz3osrKZ5lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiA+IFlvdSBkb24ndCBuZWVkIGFuIEVEQUMgZHJpdmVyIHRvIHR1cm4gb24gRUNDLiBZb3VyIEJJ
T1Mgc2hvdWxkIGhhdmUNCj4gPiBkb25lIGFsbCB0aGUgbmVjZXNzYXJ5IG1lbW9yeSBjb250cm9s
bGVyIGFuZCBjaGlwc2V0IG1hZ2ljIHRvIGVuYWJsZQ0KPiA+IEVDQy4gU28geW91IHNob3VsZCBh
bHJlYWR5IGJlIGdldHRpbmcgdGhlIGV4dHJhIHJlbGlhYmlsaXR5IHRoYXQNCj4gPiBFQ0MgbWVt
b3J5IHByb3ZpZGVzLg0KPiA+DQo+IEkgd291bGQganVzdCBoYXZlIGxpa2UgdG8gaGF2ZSBhIHdh
eSB0byBzZWUgaXQncyB3b3JraW5nOi0pDQo+DQo+IEluIHRoZSBtZWFudGltZSBJIGFsc28gY2hl
Y2tlZCB3aXRoIFdpbjExIGFuZCB0aGUgb2ZmaWNpYWwgZHJpdmVycw0KPiBpbnN0YWxsZWQuIEV2
ZW4gV2luZG93cyBjbGFpbXMsIHRoYXQgb25seSBzaW5nbGUgYml0IGVycm9ycyBhcmUgZml4ZWQu
DQo+IE5vdyBzaW5jZSB0aGF0IHNlZW1zIHRvIGJlIHRoZSBuZXcgZGVmYXVsdCB3aXRoIEREUjUg
cmFtIEkgd2FzIHdvbmRlcmluZw0KPiBpZiBJIHJlYWxseSBoYXZlIGJlbmVmaXQgYnkgdXNpbmcg
InJlYWwiIEVDQyByYW0gb3IgaWYgc29tZXRoaW5nIGlmDQo+IHdyb25nLiBMb29rcyBsaWtlIEkg
aGF2ZSB0byAidHJ1c3QiIHRoZSB2ZW5kb3JzIGhlcmUuLi4NCg0KRXZlbiBpZiBhbmQgRURBQyBk
cml2ZXIgZXhpc3RlZCBmb3IgeW91ciBDUFUsIGl0IHdvdWxkbid0IHRlbGwNCnlvdSB2ZXJ5IG11
Y2ggYWJvdXQgd2hldGhlciBFQ0Mgd2FzIHdvcmtpbmcuIEZvciB0aGF0IHlvdSdkDQpuZWVkIHNv
bWV3YXkgdG8gaW5qZWN0IGVycm9ycyBhbmQgdGhlbiBjaGVjayB0aGF0IHNpbmdsZSBiaXQNCmZs
aXBzIHdlcmUgY29ycmVjdGVkIGFuZCBkb3VibGUgYml0IGZsaXBzIGNyYXNoZWQgeW91ciBzeXN0
ZW0NCihkZXNrdG9wIGFuZCBsYXB0b3AgRUNDIGRvZXNuJ3QgaW5jbHVkZSBzaWduYWxpbmcgcy93
IHJlY292ZXJhYmxlDQptYWNoaW5lIGNoZWNrcyBsaWtlIHNlcnZlciBDUFVzIGRvKS4NCg0KLVRv
bnkNCg==
