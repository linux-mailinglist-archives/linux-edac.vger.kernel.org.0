Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B866746520
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jul 2023 23:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGCVvk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Jul 2023 17:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGCVvj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Jul 2023 17:51:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12BDE47;
        Mon,  3 Jul 2023 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688421098; x=1719957098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pVtn6eJ1tLFkYvEdKpBs/6Zv0aUFRfnsnQVT8oN+X/0=;
  b=I0PnrGZKh1ITi/6xrRxngMYgUKAg7yom8U/INwpewI0BbHu+o6/qEYM4
   FDL6Y+SO3CBC8ahoyXoqHHlG0bn5Af9eKUDvnVs++hl3hYkhk6YN5xBbR
   lnmQ/2TPs1vBI5gDyqsE99IC7q/4FwnsRGNsoCx/0Q89ZeRtLquvcuJK6
   QmFQ/iJdYlhxxu/4AEAlVz9+sHX0grqfDHjOGTfUB52iCncVzGzEiAdT9
   yt4Omdm1Hi9g3PJAsHyK+w3hOuQqhyXFQeC2WMajAUNNnYl8OEuHMhccs
   MXFmkgSkCStUso5tWxRO+VUL5e6f+v1cd+ir9tdDjb6+Jg2S0Og20cUu+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393712756"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="393712756"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 14:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="863193145"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="863193145"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2023 14:51:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 14:51:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 14:51:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 14:51:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 14:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buf24/MiU76JsmY0EyUwq670vbpDfQ9vDOfhRJfll5tUByWEWavv4kyntQQm0qPDUg36lhqhCRVVP2zSyl3u+PquAQ+36FD5lqZAG8ZWV3jQkPhFEgT/UsR2dzzR1bpoHG4DS0pnX4TU6KmLwjdRT2nHd+YiPfYwAuc3Lf9ThASwsAGFzhs0QIYdXjYS2c5pJAkRst+IuRdLv7JHxcDrJbEEbquDF8O9I74YQUwlAsssMBo3+zjRvsdgyiz/mw4w8s/46EETBbvKbJ3SBYvmNAscbpHmPTd1UyDUwE9eZGna2wuqH9/h1v9Nyn7VQBPcGY8SFE/UnBbrtMFiUXy1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVtn6eJ1tLFkYvEdKpBs/6Zv0aUFRfnsnQVT8oN+X/0=;
 b=DEw/V9x75h6q7Mc/dHEc5/cWVGioRXsNpZePK2hnk4MpE49VnIRptX3DTAZ10NoqTvSJNf9nc+AI3+vlkpXUJvsVDHfp3KeMmrcfNUxDINlhq+wK0ORemJO4nUCDJA2kkymFd+NMXfhldd+O/vwRLnftojHy41Q56UPbQtXFTj9Y3diB2U6QNqucFMbx4jzeR7i9YiR1M9iOgJB1wzG0uEfWjCxLyWo3KCFKuoPS0jIQyEyMrXJiiN25Ptm75gsx+ziFlu1hJCBxDVdNZAtcVLjaGZzJARoiSX2eaYKjxs7AkfkWcDYs70LCocyKmdLwy0/A5n0U/uQeW++TcB5LNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 21:51:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 21:51:33 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Koba Ko <koba.ko@canonical.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Topic: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Index: AQHZrc6A28+shQPK+kOOa0lv+6OuYK+ojzaQ
Date:   Mon, 3 Jul 2023 21:51:33 +0000
Message-ID: <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230703162509.77828-1-koba.ko@canonical.com>
 <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
In-Reply-To: <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM8PR11MB5669:EE_
x-ms-office365-filtering-correlation-id: cc5a5e2f-1359-40c7-cef2-08db7c0faa96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOn8VvrM05pLcm5glQE7ka6UOJK62dDRQDVgIQ5N9jGniKKK4OBa46YwHT9Oi8SQzySIWF09c8EkQ00673q1BhCH3ybSqfc0NZQ682q0AfKSkH0+3i5hUZ2l4BQ+q2IINk+W8+B8V5CztGpPduuRsSqHTol5O3G+p5U07T20H9dC/vd6wm9WYY5pMHyAtd0tVpD3sLknkG9lE8n5TRNHzmU4rlXR76gmh2JIFQsTgjQAfIkuUW5khF+NVDxzvyOiyOEYTYs2V4OGHo3FbhaBRVQ9Cv3T1jq6wnUHveI7MLVsedFHzdst/sBoDtmBz+OIv5sD0ec//ZQyik0KBmA5JEvMPY4Ob229H8Ap3sOLGwqd47p2pUjL8iZ1OrP3BJANoaTVimnJSkUVlO76noAxrQgTuHYWCEdoJFe3SUjnGWnBBQrH0PS6Lg3k2GmrSfKUaNCWL2jzJzmdJNt0q3wEy2GsP1FY0zxpp5ubOKguyJu9b5OJCGZBthhO/HC8p0PK0aIKlGwlUV+PiZElJtEP35DVRqBJlgz6s/Iwr/wVdztP9DuGCPCCl0iHv73GVYdaZzE38Qej/2FK/5MA8KqX5lapOYdd8BTtpcB7kX7uTnw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(26005)(82960400001)(478600001)(9686003)(71200400001)(966005)(6506007)(86362001)(186003)(38100700002)(66476007)(64756008)(66556008)(4326008)(66946007)(66446008)(83380400001)(110136005)(7696005)(76116006)(316002)(122000001)(5660300002)(8676002)(8936002)(52536014)(38070700005)(41300700001)(2906002)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHExOUl0M3g2UHhCN0E3Skh1QkJ6WGx0Q0ZGZlZta1BzVXQ1V0Q4eWZGdEZW?=
 =?utf-8?B?S1F6UlI3SHhRaUhjSjZLQkYrYjNSZ1RTeHdXZTU3dTNwTnBDS2J3SlBXdmVD?=
 =?utf-8?B?L2NNdW9QcXY5ZjZDVmNPcmRXeGNmY3greTh6SUtUc05UOTRiQ2JzTmsrYnBI?=
 =?utf-8?B?SEVIbFFqQi9odytCVklWUHZNR3FYZloyWXRpWUd1TzllUTdWRXV4WHFwdnVC?=
 =?utf-8?B?a3ZiZmcxbDhmNUc1Y2dvdkdHcW9FeC9FMnlwWFl0ZUkweGQ4TWczMTdNRXZF?=
 =?utf-8?B?VzVwd0JuVlowN3FTMy9DbEd2TzhJZWU2ajVEVDBJaEpOQno4Z21OWUJVckZq?=
 =?utf-8?B?SmM2b1BhS0VFNjVNNEo1eHErUS9lb1JzN25PRE13cDJ1UnczWWdLQkVicGFy?=
 =?utf-8?B?NmpkTUloZEgvb2ZISGE3SW9CSHJTcUFXU3FrQ2p1SlQrYVlkOWxRRFJZZCsx?=
 =?utf-8?B?bWhNUzVCTStpNTNHcGZXYUZJRTNQZTRLR1YyL3RheWxyNVZtV0djMndIcVU3?=
 =?utf-8?B?RHpoZFZsSWpnTGxwcUpqN2ZkU3d1czlScVEzUjNyS0N5bWVsZGE5OVZtRlEx?=
 =?utf-8?B?VExEVkpNeU5RNVlKZnF6R2x1UDIxZ2hnY0hnU3NCMFZXaWRXMGJPYnJ0bmdv?=
 =?utf-8?B?Z0NSSkQwVnAvTXRUTjgrblNyWTNaZmJhaVJXQ2p2QnBHS1o4VXlxMnJnSjZN?=
 =?utf-8?B?eStwRFo0MEFZYTdtSXdkSzhKUnlGZ08yekdiUTc4OWsvZ2ZQclZBV1pzY2pa?=
 =?utf-8?B?ZHRNdjJDRUtlRjgwMTlUbWdXOUhKWkp3eVJwdElxVnhBczhyKzBWM0EzWDV5?=
 =?utf-8?B?Qm9kZmt4clZIZkM4V3R5OUtIcU5kWW8zZWxxUllpb0RacDJPUWJkMkdYMFlI?=
 =?utf-8?B?c3ZkNUhJcVYzd3NYSzhrNHRodThwSnFhZ1dDL2VBTXZ1MXdPYjBpUU9tYWJt?=
 =?utf-8?B?ZEIxaExpQlNSZFJRV1FsMnA0NlNWenZDOVhzWmxyYmcvaVpsRTB2ZTZtOHVM?=
 =?utf-8?B?cVRTMDhEMlljTWxiNjQwWjdoUWRxeURVVDF0aFd5U3gxeko2MDkvL2JnODZP?=
 =?utf-8?B?ZTFScWx2VDNnR1lXNnB0U25lVzNNenpWamoreXVaMmNNTVBLdWFzUHRMWWZ5?=
 =?utf-8?B?dU84VU9VSVF1K1IrOEI0Z1IvTDRMYVNjVXY3NmtRSzFuZFRlMUxiUUFvc3o2?=
 =?utf-8?B?aHhrVkhuUkp0R3c4dUhiM1h1THREcmFXQUhOM1A3cytEa2IwQkZaMkFGVG5n?=
 =?utf-8?B?cVJWam1QNm1QanlVdGVvKzNURFRlb0VnNXFmZzJUaDdyb0RpTWp4K3JVNFRi?=
 =?utf-8?B?N0ZjakJycUQzeWlza3NYVzdNNjkvbm9mNk9wOUg1NFg2NDg1UUV2ZHN3ektV?=
 =?utf-8?B?cGVia1ErczJKSGNwN05aTVpZMGoxSkZPaVJnN1Q5NmdONldYU0RTTFBtV3RL?=
 =?utf-8?B?SjNua3lZT0FrWmFsVldmNVVodE8xWFljTkRWRzduZ3JHUWRLM3oybzkxeXFt?=
 =?utf-8?B?UWlWaUIxUm5TR2I5cUxBWmNUbHNaZnJNeUtHV2lhZ005aXdBc1pRREw3UTVr?=
 =?utf-8?B?SGlXTUZiV1hMeHNMcGxWVmRSc2hOZFdCSFpZTEM2UGFyMUNnNmZXSWQ5bEg3?=
 =?utf-8?B?Yk40RHBqNWl0TnFYRkk0eVZVYmV3Sisyc0xMZWlCS0Y5U1hwNFhCYUdrbS9J?=
 =?utf-8?B?ZERIN1RuZjdJRnlKR2U3VEIyZXdZSGVEdDRoQlhkR2htaHZwSnVTWHJPZ3d4?=
 =?utf-8?B?YUhadWJ6MGt0RU5HRzU5VE53RHBERmJ6SE9hakNXRUhDVHBFbUwrUjRHNWk4?=
 =?utf-8?B?TkpXendOVm1KVk1MK25uQUdlZlc1bFpwZlZyTlR1bXN6RkVlODI0aXdHcHhX?=
 =?utf-8?B?Y2hSa0dYVUk4OWFrNHNzSlBMSjBYNjZyUUxqamdYVnNjMTdoSTJ6T1dqM29u?=
 =?utf-8?B?RnVlYVJkb3JNYWhoOG5qMklkdUt6YW1QN1hzNUFDV1UwQ0lIakJvaThBQTFY?=
 =?utf-8?B?UFhsc1d5SU9EWGZxNHE3ZUoreGVTdEN2TklsaEsvc210aVRxQUtyOE1yNWEy?=
 =?utf-8?B?VkxiWmszRHZHQkZTY0UycE1maFZiL01hbmp0UmJxT3lBUVNjQVNNeUs2Ylp6?=
 =?utf-8?Q?tvV4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5a5e2f-1359-40c7-cef2-08db7c0faa96
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 21:51:33.0972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4s10pfUArnUbSC/yB7WmzwL/UlbgF7aFaixGx9t/IpP9nMRj84+wBk4yMBtP8Lkn5GFlwGojQi+sFbH3swxL1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5669
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

PiA+IFVCU0FOIGNvbXBsYWlucyB0aGlzIGVycm9yDQo+ID4gfn5+DQo+ID4gIFVCU0FOOiBzaGlm
dC1vdXQtb2YtYm91bmRzIGluIGRyaXZlcnMvZWRhYy9za3hfY29tbW9uLmM6MzY5OjE2DQo+IOKA
pg0KPiA+IH5+fg0KPiA+DQo+ID4gd2hlbiBnZXQgcm93cywgY29scyBhbmQgcmFua3MsIHRoZSBy
ZXR1cm5lZCBlcnJvciB2YWx1ZSBkb2Vzbid0IGJlDQo+ID4gaGFuZGxlZC4NCj4gPg0KPiA+IGNo
ZWNrIHRoZSByZXR1cm4gdmFsdWUgaXMgRUlOVkFMLCBpZiB5ZXMsIGRpcmVjdGx5IHJldHVybiAw
Lg0KPiDigKYNCj4NCj4gKiBQbGVhc2UgaW1wcm92ZSB0aGlzIGNoYW5nZSBkZXNjcmlwdGlvbiBm
dXJ0aGVyLg0KDQpUbyBiZSBzcGVjaWZpYy4gSW5pdGlhbGx5IHlvdSByZXBvcnRlZCB0aGlzIGJl
Y2F1c2Ugb2YgdGhlIFVCU0FOIGVycm9yDQpyZXBvcnQuIEJ1dCwgYWZ0ZXIgY29tbXVuaXR5IGRp
c2N1c3Npb24geW91IG5vdyBrbm93IHRoYXQgdGhlIHByb2JsZW0NCmlzIHRoYXQgb25lIG9yIG1v
cmUgb2YgdGhlIHJvd3MvY29scy9yYW5rcyBoYXMgYSB2YWx1ZSB0aGF0IHRoZSBFREFDIGRyaXZl
cg0KZG9lc24ndCBleHBlY3QgYW5kIHByb2JhYmx5IGNhbiBoYW5kbGUuDQoNClNvLCBpbiBWMiwg
dGhlIGNvbW1pdCBtZXNzYWdlIHNob3VsZCBzdGFydCB3aXRoIHRoZSBpbmZvcm1hdGlvbiB0aGVz
ZQ0KdmFsdWVzIGFyZSBvdXQgb2YgcmFuZ2UgYW5kIG1lbnRpb24gdGhpcyB3YXMgZGlzY292ZXJl
ZCB3aGVuIFVCU0FODQpwdXQgb3V0IGEgd2FybmluZyBhYm91dCBhIG5lZ2F0aXZlIHNoaWZ0LiBO
byBuZWVkIHRvIGluY2x1ZGUgdGhlIHdob2xlDQpvZiB0aGUgVUJTQU4gc3RhY2sgdHJhY2UuDQoN
ClRoZW4gZGVzY3JpYmUgdGhlIHR3byBmaXhlcyB0aGF0IHRoaXMgcGF0Y2ggaW5jbHVkZXMuIE9u
ZSBpcyB0byBjaGFuZ2UgdGhlDQplZGFjIGRlYnVnIG1lc3NhZ2UgaW50byBhIGNvbnNvbGUgZXJy
b3IgbWVzc2FnZSB0byBlbmFibGUgZnVydGhlcg0KZGVidWcgb2YgdGhpcyBpc3N1ZS4gVGhlIG90
aGVyIGlzIHRvIHNraXAgdGhlIHVucmVjb2duaXplZCBESU1NLg0KDQo+ICogSG93IGRvIHlvdSB0
aGluayBhYm91dCB0byBhZGQgdGhlIHRhZyDigJxGaXhlc+KAnT8NCg0KVGhpcyBpcyBhIGdvb2Qg
aWRlYS4gIFVzZSBnaXQgYmxhbWUsIG9yIGRpZyBpbnRvIHRoZSBHSVQgaGlzdG9yeSB0bw0KZmlu
ZCB0aGUgY29tbWl0IHdoZXJlIHRoaXMgY29kZSB3YXMgaW50cm9kdWNlZCAoaGludCAuLiBnaXQg
YmxhbWUNCnNheXM6DQo4OGEyNDJjOTg3NDAgKCJFREFDLCBza3hfY29tbW9uOiBTZXBhcmF0ZSBj
b21tb24gY29kZSBvdXQgZnJvbSBza3hfZWRhYyIpDQpidXQgdGhhdCBvYnZpb3VzbHkganVzdCBy
ZWZhY3RvcmVkIGNvZGUsIHNvIHlvdSBzaG91bGQgZGlnIGJhY2sgbW9yZSBpbnRvDQp0aGUgaGlz
dG9yeS4NCg0KPiA+IFYyOiBtYWtlIGVycm9yLXByaW50IGV4cGxpY2l0bHkNCj4gPiAtLS0NCj4N
Cj4gV291bGQgeW91IGxpa2UgdG8gYXZvaWQgYSBtaXNwbGFjZWQgbWFya2VyIGxpbmUgaGVyZT8N
Cj4NCj4gU2VlIGFsc286DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9z
dWJtaXR0aW5nLXBhdGNoZXMucnN0P2g9djYuNCNuNjg2DQoNClRoYXQncyBhbiBleGNlbGxlbnQg
cmVzb3VyY2UuDQoNCi1Ub255DQo=
