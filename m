Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99605613E1A
	for <lists+linux-edac@lfdr.de>; Mon, 31 Oct 2022 20:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJaTUn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 Oct 2022 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJaTUm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 Oct 2022 15:20:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A2211473;
        Mon, 31 Oct 2022 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667244041; x=1698780041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M9HOPhK1TOBIKJzXcrNUZyAj+wSbMliWQJ133RKDFlc=;
  b=kptgvYbgStjbVM/AoEVIHu8RkcWPCU70HKcC73yOp3hViufSS7pwuw6T
   ZdDYcfUakOApQwSh5n2BuDqkaBE7CRU8e1rhwfsp0cffGOfUjAw7EaCJV
   nwfrgLabyz4sOHGItFc8p8YtMRobgc8iKK9Sauwf9GWV3d3xyoxGojgSu
   fSal+MrucwRXj3VhOKObemrO8WrDqnqsirU6CAdEqQU3C525FkrIN1faC
   OIVwWj2ax3b7yNXxCVxAQq1VQ1VIeCDf3jAGRu5zJthIS0wPST5hr2p3D
   n9HGmtYGOwDdk4XwJ/c4KKqnDQuLCP7gm0M4QiTtf8KZRxWn84RyWZi3K
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="296400209"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="296400209"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 12:20:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="633635734"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="633635734"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2022 12:20:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 12:20:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 12:20:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 12:20:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 12:20:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GguyBuAcLf/Tl6O6TuuSxmYB9r357SzJCwP0njbslKOmF9ZmaQ9Y7MGlWz+oJMlmjRcPbLnm2ldsE9L+1uiEPiI7rTN3s9pR4BbRey+k/DWwPyDzVz19C/Pbw8/Xuq/DkF9BlMk1varAd90fNUFQF3KmUsq8CElBcsEgqGfzyl646mW6kaqHEOw7FvDnf+uizNSjJzH/+YS2kAmpyL31NurcfRhn3qPW4pGU8T/sPiAnt155PI+w7L8apE0Y0Vd08iSXYd7y8Wgu0kOw2Lx2NouCHvulo99r0mhwv6zz5xTlERaTUs6HrPIGvmJoOXlh4LMoYF2PKYuSIDAFNgkvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9HOPhK1TOBIKJzXcrNUZyAj+wSbMliWQJ133RKDFlc=;
 b=DSqRBM8aaLrggjtF8C+8VOpObdsBqfLyxcb8YqkPM8pX4X1SOLve6k4lIS4Z+aeZdQXt4hAzUD6wEfUYdZcvrJOgLDuXi4D3BqRDiZcEjDvNPy2xVsIB5o4YKodse+g0jQ/XuchkG3NBJq+9EMEOps7JRcCSyT5qVi9gDA5uCqrWqHPw8R1sfmI9wbcyxDXWpJ2bgwfaHKrk1a89nq6BPBpbCaf5xXiSqGgQRzmSHXbQ+lo5ygRv5MN38bkhCvmyDtg9j+gGlyjaBJj1FLiIGqNyaR4hZzo+5/3ZgwnFuGgMW+qNnDbYMrjHsTWkFlEE5rqaL10B/1VafEqiC33HLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 19:20:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::51de:f739:3681:b16f]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::51de:f739:3681:b16f%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 19:20:38 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/mce: Dump the stack for recoverable machine
 checks in kernel context
Thread-Topic: [PATCH 2/2] x86/mce: Dump the stack for recoverable machine
 checks in kernel context
Thread-Index: AQHYzrzD+dYG/dJ+8UimjxgTckOY+a4o8q2AgAAG7kCAABgzAIAAARiQ
Date:   Mon, 31 Oct 2022 19:20:38 +0000
Message-ID: <SJ1PR11MB6083564E9626FFB4681CA3B7FC379@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220922195136.54575-1-tony.luck@intel.com>
 <20220922195136.54575-3-tony.luck@intel.com> <Y1/7ewEgVZ56KlJp@zn.tnic>
 <SJ1PR11MB6083593A0D18EEE0074E77ABFC379@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y2AVmOdEtTl5e68l@zn.tnic>
In-Reply-To: <Y2AVmOdEtTl5e68l@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5070:EE_
x-ms-office365-filtering-correlation-id: b99b1ce9-cc3d-467e-7f65-08dabb74fe58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8C/4ZPJ2J13nDsUNNoWo8q20965w1MZoMJeq5oJW2yudJXt2YYpd3aKbCHxc278rWZbDgLxlrb4KyWEffJJ6NdR6+WyCxQrDL4FQV0jA+FpQvRzoUrPt631bA1XRuVG1BHXVMN+bFK0bl7ZrYuGWJBCT1MiZfqLPR532BKha82D08bhL8E0DtMrsVbqoEJsqTPBvZPWGyzcUBN9uWH+0fkquAEU45O6AmzHFdwwJqUH6e9xmNxQ+ZF/p7QjZVNhS8g84fOZqODepQQQomKk8d5MJ9txZJNFQLV3CmG/sAjIrGyJCAt/DPgJixT4R5HKAs7GbnXOMwWHomOJbP0qe7D+az8yNtmpUoRgwr120gFG/+fGeFCcP1F/sTv//n7PqNQoJOx/acvrrMIWH1Wvz6Fvh1vrbPHuiUKoF2FDyV6Wtrrb2Af8zqVrUhZ/JhiKXJi7hZjNqzCFc6MTym/eeB6soFP9L3J3HmUdJjJ+KUe57nzhWWPWZyEZHu/v6CyC+g0s05ammP41ZVaRa4STCUk1omgoEJ1bugUcbtLYO5qwLx2i0/I7eaRh+Kt70MKmp3GSbQi19evb4frGlCJeCRPSWNSMoXuAMhpp7Hk/fRIBcCEbNnkSfaBwhHcBhT9bw3OncDmTGL9DLk2Uf8EyuksSh2A9MZ0/Xd54wDDPIL10bx5aUcSssZD6D2OLljPK+Z8QBeZdvf29O1L6ViFAqaAr9qtX+Ia7U/pHLbPn917KPAMvkFuQTJDdpwAhe2bz7g8+bqmNlAbFA0s9SwI1+hl2peJbPS6u6mL5oxrjyWbqleXnKYeI+dPgFyhFgQns60T4c+ojG6pbHO1uD8ywc9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(86362001)(55016003)(2906002)(71200400001)(966005)(122000001)(38100700002)(38070700005)(82960400001)(33656002)(9686003)(186003)(26005)(316002)(66446008)(8676002)(478600001)(6506007)(64756008)(66556008)(4326008)(66476007)(7696005)(6916009)(54906003)(76116006)(41300700001)(66946007)(52536014)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDRBbE0rV1ErOFVjblE5TW9sTHBsYWtHL3B5NU1aQjQ3RGZZRWRHcFY1QUNn?=
 =?utf-8?B?RVJBN0EyOXdodlhodmVjblhud0JlaWs1d0FoYjVpcldSdk9tcDh6STluWXpx?=
 =?utf-8?B?bnZxYnJYSFNnMmRaV1dpa3RKMTdaZ2t1VlcycHBMdkVsTVhiTGJZL1p0OEFG?=
 =?utf-8?B?cVRLNzZVdElSK29tZGo2OWpjYzVSNE5FWExkS0h0RHVhMlU1c2F6NDdqSWpW?=
 =?utf-8?B?Vm9qVTFHenpORlJkaGhndllPNTdVRFFxTldyZkNxR3dOUU1WSEx5c3h0VHA3?=
 =?utf-8?B?ZzlWQTVaMDN3aXR0Q2J2dGJHblV6U2JDVmJ5RzFHdk5nWWw2YTVvZTlPbkxm?=
 =?utf-8?B?bUJrbXM0R3J2OEtNYzQ2bm4wNFVhRnV3Z0UrZ2xhTndaRlNKRFhvSHNsdjFz?=
 =?utf-8?B?c0tzUzc2YUVGZnBlOVE2YTU0d3hkMVZDTTh6OHlub3Y2djZGUlpna2ZGc0xr?=
 =?utf-8?B?Vyt0K3VUTnZEb1JoNUtoTjhjN1ZmTVo3bjUveGJxL1h0cktBRmlPQXpMeDgz?=
 =?utf-8?B?WnVNaFNESHFzZlYvMHpiaG9CdkI5UDlPRWNCQVRISmp4Vk5Vc2VyaWhndGVS?=
 =?utf-8?B?ZGR6NGlEZDJ3dzRhSjZiTTd4SzVHRFlTK1MyR0hyeGV4YmNpd2NzY3hFdVV3?=
 =?utf-8?B?czFBRnBENWFSQ29YQlBtYzFUNm1Ib2ZTNklCYVhrV2QrK0VlQWl0VHVjNXFN?=
 =?utf-8?B?Nnh6Q29xVGE2eVdScTJxYjhLRlF0UDA2OUpxeG1yajJKZ21xZTV4d204STFV?=
 =?utf-8?B?UHNYeTRSRWlyZCt3ZHd4N0prckowc3FKWFRVTFR5eE9lUE5SVmxlSHF4Und2?=
 =?utf-8?B?T2hhTFhqNlppYVdIT2NzYWU5VHJMbjQxOER3Y29pZk1xM2xhelNSd2EvS0pY?=
 =?utf-8?B?dXBLM3czOEFLOHVDZkkxa0RNdCtkNUp4NklheUo1QlZNTlhFUDY0VG5sRXor?=
 =?utf-8?B?TUhDUmRxVVM0N2U5WnRYekxOSklIMUcrV1R5dDhYWUdaZ1lLMS9Bc1VrWXRh?=
 =?utf-8?B?MDIxR2F2NE1sbnBBMzRnU3NGRmR6SytQYUNLRXZ1MjJZeXIrNHFCZWRUVDd1?=
 =?utf-8?B?cWVOTHFBdU5zaHN5djJ1Z2UxSHBtekR2ZDZkM2F3RmlPSUN3a3dIKzVmaENS?=
 =?utf-8?B?cmRRd2ZPUFU1WlZCWmdnVDY4MGd5YzRaanlGRDBFa3dSRytCYS9RL3E5bi95?=
 =?utf-8?B?WWJxSWQraEdVdUNaQzNXMkpITXpSREo4WWV1bXplWEZlUXZHYnlLUktWMkQ2?=
 =?utf-8?B?R3dGOGQ2QUdWUHJROEo2TnNQRzl4U3h2dy9adk5zWTNhM25nRFlmNU9QUFJl?=
 =?utf-8?B?U2E5NUxpSk5PL1RTd1lSM0JBTjlJd0RUS0RJaWowUUFJcWVpOXBHYmVITnRs?=
 =?utf-8?B?Ym5pdmovSVFrWWtLMUZoNEdOM05pRzBTODNaZXc0QkJLVHBJR0xvMXZaWTd5?=
 =?utf-8?B?aEVGS3p3V3pQWVo1TWRNZ3JNeDB6dUVjekdsZlI0bjFhdGxOSXZyYmRuOCtO?=
 =?utf-8?B?Z2gyL3EzaXdvaGZWb3BpSFI5Z2E4b3hiLy9NemtUWFhjcjRTbzZoNXdWRHBt?=
 =?utf-8?B?cVExMjl4NWtKaUwvMGc0MXZ4WFZKTlRtVTUzd2V1cHlrQWp6dTVhTmJuVHlu?=
 =?utf-8?B?bjRVazdRVUtka2hnem5hZFdpeUlYaHpET0ZqbnVvbkRrU2FEd3hDUjJiK1NK?=
 =?utf-8?B?VGxFRWpucWhiU0RTSFZUZm5QNXRJSGJrUlFZVnFveGZaQTkxQWZGZ1IwVlJY?=
 =?utf-8?B?Y0JueWtOQ1EwRnJuTHF1U2NwQ3VEcEQrZzVRRzM5TmprdzdEWFI5Z2lnUm5q?=
 =?utf-8?B?WWdaVkkzQ3JCNDh4aVZpVkYzcmhzYkJsQmlvTFRZSUYzQ2VLNnNaMG9ibzNz?=
 =?utf-8?B?Vm04NFNYTlFUaFFSSGpOR2lEc3daSFMxY0UrNldzaCt6OUZqbXYrUlVoSnFG?=
 =?utf-8?B?N0k4OTJkMXBPQW5JbVJlY3pNaWFHQlgrbzZJOEk5dk0yU2FTYlR5TDJWZ1ZN?=
 =?utf-8?B?eG8yYkdCTEJxR3RCREQzUXZyQ1Q3NHV0QkJIeVM4b0R6WFdQaUdaaXh2WWVL?=
 =?utf-8?B?aFpxSzI3ZWVHOFlzZzFtMHJDMlh1TC80dzhXK3pnVzcyRytmVExwV1QyWC94?=
 =?utf-8?Q?Tc7cDPlXTFp2AP4Oh6fT22s8Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99b1ce9-cc3d-467e-7f65-08dabb74fe58
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 19:20:38.3534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeFvFsVfFaOJHgyU2OQpPJWzkbRhtnFMS2F9wyG0NoPtWMWPJouZTihJBtFGPk4CIaR1qg6lEgunoih4iKqaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBXZWxsLCBpZiBvbmUgd2VyZSBzYW5lLCBvbmUgd291bGQgYXNzdW1lIHRoYXQgb25lIHdvdWxk
IGV4cGVjdCB0byBzZWUgYQ0KPiBzdGFjayBkdW1wIHdoZW4gdGhlIG1hY2hpbmUgcGFuaWNzLCBy
aWdodD8gSSBtZWFuLCBpdCBpcyBvbmx5IGZhaXIuLi4NCg0KU3RhY2sgZHVtcCBmcm9tIGEgbWFj
aGluZSBjaGVjayB3YXNuJ3QgYXQgYWxsIHVzZWZ1bCB1bnRpbCBoL3cgYW5kIExpbnV4IHN0YXJ0
ZWQNCnN1cHBvcnRpbmcgcmVjb3ZlcmFibGUgbWFjaGluZSBjaGVja3MuIFRoZSBzdGFjayBkdW1w
IGlzIHRoZXJlIHRvIGhlbHAgZGlhZ25vc2UNCmFuZCBmaXggcy93IHByb2JsZW1zLiBCdXQgYSBt
YWNoaW5lIGNoZWNrIGlzbid0IGEgc29mdHdhcmUgcHJvYmxlbS4NCg0KU28gSSB3YXMgcHJldHR5
IGhhcHB5IHdpdGggdGhlIHN0YXR1cyBxdW8gb2Ygbm90IGdldHRpbmcgYSBzdGFjayBkdW1wIGZy
b20NCmEgbWFjaGluZSBjaGVjayBwYW5pYy4NCg0KV2l0aCByZWNvdmVyYWJsZSBtYWNoaW5lIGNo
ZWNrcyB0aGVyZSBhcmUgc29tZSBjYXNlcyB3aGVyZSB0aGVyZSBtaWdodA0KYmUgYW4gb3Bwb3J0
dW5pdHkgdG8gY2hhbmdlIHRoZSBrZXJuZWwgdG8gYXZvaWQgYSBjcmFzaC4gU2VlIG15IHBhdGNo
ZXMgdGhhdA0KYWtwbSBqdXN0IHRvb2sgaW50byB0aGUgIm1tIiB0cmVlIHRvIHJlY292ZXIgd2hl
biB0aGUga2VybmVsIGhpdHMgcG9pc29uIGR1cmluZw0KYSBjb3B5LW9uLXdyaXRlOg0KDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjEwMjEyMDAxMjAuMTc1NzUzLTEtdG9ueS5sdWNr
QGludGVsLmNvbS8NCg0Kb3IgdGhlIHBhdGNoZXMgZnJvbSBHb29nbGUgdG8gcmVjb3ZlciB3aGVu
IGtodWdlcGFnZWQgaGl0cyBwb2lzb246DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW1tLzIwMjIxMDEwMTYwMTQyLjEwODcxMjAtMS1qaWFxaXlhbkBnb29nbGUuY29tLw0KDQoNClRv
IGlkZW50aWZ5IGFkZGl0aW9uYWwgb3Bwb3J0dW5pdGllcyB0byBtYWtlIHRoZSBrZXJuZWwgbW9y
ZSByZXNpbGllbnQsIGl0IHdvdWxkIGJlIHVzZWZ1bA0KdG8gZ2V0IGEga2VybmVsIHN0YWNrIHRy
YWNlIGluIHRoZSBzcGVjaWZpYyBjYXNlIG9mIGEgcmVjb3ZlcmFibGUgZGF0YSBjb25zdW1wdGlv
bg0KbWFjaGluZSBjaGVjayB3aGlsZSBleGVjdXRpbmcgaW4gdGhlIGtlcm5lbC4NCg0KPiBBbmQg
dGhlcmUncyBhbiBhdHRlbXB0Og0KPg0KPiAjaWZkZWYgQ09ORklHX0RFQlVHX0JVR1ZFUkJPU0UN
Cj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIEF2b2lkIG5lc3RlZCBzdGFjay1kdW1waW5nIGlm
IGEgcGFuaWMgb2NjdXJzIGR1cmluZyBvb3BzIHByb2Nlc3NpbmcNCj4gICAgICAgICAgKi8NCj4g
ICAgICAgICBpZiAoIXRlc3RfdGFpbnQoVEFJTlRfRElFKSAmJiBvb3BzX2luX3Byb2dyZXNzIDw9
IDEpDQo+ICAgICAgICAgICAgICAgICBkdW1wX3N0YWNrKCk7DQo+ICNlbmRpZg0KPg0KPiBidXQg
dGhhdCBvb3BzX2luX3Byb2dyZXNzIHRoaW5nIGlzIHN0b3BwaW5nIHVzOiANCg0KLi4uDQoNCj4g
aXQgaGludHMgdGhhdCBwYW5pYygpIG1pZ2h0J3ZlIGJlZW4gY2FsbGVkIHR3aWNlIGZvciBvb3Bz
X2luX3Byb2dyZXNzIHRvDQo+IGJlIGFscmVhZHkgMSBvbiBlbnRyeS4NCj4NCj4gSSBndWVzcyB3
ZSBuZWVkIHRvIGZpZ3VyZSBvdXQgd2h5IHRoYXQgaXMuLi4NCg0KSXQgbWlnaHQgYmUgaW50ZXJl
c3RpbmcsIGJ1dCBhIGRpc3RyYWN0aW9uIGZyb20gdGhlIGdvYWwgb2YgbXkgcGF0Y2ggdG8gb25s
eQ0KZHVtcCB0aGUgc3RhY2sgZm9yIHJlY292ZXJhYmxlIG1hY2hpbmUgY2hlY2tzIGluIGtlcm5l
bCBjb2RlLg0KDQotVG9ueQ0K
