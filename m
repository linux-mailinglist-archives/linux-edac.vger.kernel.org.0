Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5525F641973
	for <lists+linux-edac@lfdr.de>; Sat,  3 Dec 2022 23:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLCWVV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 3 Dec 2022 17:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLCWVU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 3 Dec 2022 17:21:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E301C434;
        Sat,  3 Dec 2022 14:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670106080; x=1701642080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o3YhrsRDn0Y2hkxqu0yNKhr2lQWQay9EE2QxqPqLiGE=;
  b=IAdq8zVk0sPhWIl04ZT9kaMMmzMeXV35jtpQsdEMOvGSuH7StTsxJ2ih
   HBZWgCIioo9vYFIkIQ51EkwQOyY/muEbvyaWjKaI0Zp7czhIuGe6aBDVb
   B5JpZhGwQoL+EeClVrApugUa/s/w8PBuO68oZxmU4yJzhWbU83xWflhVo
   ec0gPXYzVF1TPGWwDL6OZOHSgrPNYGU70SQ4p+71KDJZsyjrPHhWpDKGI
   N12OqqDV5td1w0373TVE5FKaGrTeXa5fXDn1zQf4V3IDJ9DC5vzTpW4Ei
   uvbiE2Uw+sLhO7gHCmo1cxZYQql8iMCHQIkAaNx1YZVnRV/nO27/iPG0I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="296507908"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="296507908"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 14:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="647535976"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="647535976"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 03 Dec 2022 14:21:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 3 Dec 2022 14:21:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 3 Dec 2022 14:21:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 3 Dec 2022 14:21:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 3 Dec 2022 14:21:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7ReZk2IQHHSOcxsNM0xYbTJlbz4GyHKOW6z1DyH899l+eJPw2g6p1Ef67/YfgR4Ptog2R9foyePx3OXcglVnLlY45xiFOACZtL5EgyxoLbaZBBZL3g+BQp2H0O5YVXo73JhJeb7J7x+wyNpWR57j7sl+RVv5IyV4Fd/MAPah+PIicAIgzA2X6j8TnVJqRBQladJ9sETEkJsnNg+dIL+zSvEIXP40vstlbwUmZyie5AcG5j4CWVl3bZ1L3fku7IFgNq2iox2Re6DP2V7Snbccbp2svQ+bRmSoWYJctmwfmft13Ufusv24z1VKCFZWFILlWoLcKooZUArHYmiFcJUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3YhrsRDn0Y2hkxqu0yNKhr2lQWQay9EE2QxqPqLiGE=;
 b=hEZq0I+0OMbb10MfWKbYxl1po+J0WYk9+jjb4c6da6H85+BU6bCymVMTi2SSCh6g/fR9NOlgYy0gNiPzw+2qiqPLJVWjOnRSVs1cvjEvbdeZnVIB4hTohISWnI8fvY+XVUQq7uAD7a194vlw+/QJjv3k0Vgh+5wDYqIjlIn8Jpo3pylqaHcJ/spjjjj6WNOPQqosnYncvFqMDowfXrSAhv9urDLUKVQufCwwq2TxE9Zy6veIExycJnJhMayObEwVaMy6jusZtylJf4o9eN9eQfI16gRp0UrrAXzRiaMehhaH8RSuUeT+cwr6ZtTPcvn7vzVFod3s0vjtiV5qZkUN/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB5031.namprd11.prod.outlook.com (2603:10b6:510:33::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Sat, 3 Dec
 2022 22:21:16 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%5]) with mapi id 15.20.5880.010; Sat, 3 Dec 2022
 22:21:16 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xu.panda@zte.com.cn" <xu.panda@zte.com.cn>
Subject: RE: [PATCH linux-next] x86/mce/dev-mcelog: use strscpy() to instead
 of strncpy()
Thread-Topic: [PATCH linux-next] x86/mce/dev-mcelog: use strscpy() to instead
 of strncpy()
Thread-Index: AQHZBt9A71m24QU0eE+uWk8CipUvUa5cvQBQ
Date:   Sat, 3 Dec 2022 22:21:16 +0000
Message-ID: <SJ1PR11MB608368E2784D461E3CE3DAECFC169@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <202212031419324523731@zte.com.cn>
In-Reply-To: <202212031419324523731@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB5031:EE_
x-ms-office365-filtering-correlation-id: db93d2d4-5bb6-4600-774d-08dad57cb20b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n+H+uUr7Ij1fzjht4OZNDYRmO5gpeogMT6iZV1rW6lgFjWR3ChpK9HYwsnOrJ8MabDxe9MqXyS9LM56tlCFYHBhdNFRxD3uUlEKizsnigOlqlbFYZHKDgR26kvPS5PGJHNypV61l/2yUhdcxsn5+uEH8hQ08Vqf8Ri2ytu0qQFeCuWbZyW0GtGkO1up3lGsQI5vXDFFSsZDEpECQN0Tq9itAGiOsD01rWL574nvU8VBozT6qNGuLEvZ7VMLHBZ/NZmFX5ZSl+dNOkv/zLMc5e251M8kvTAcnVTNr5tPzXcZX8HTWCe2O3XBX3UAHP6UQ4atdjY46VZ03s6+gjLIZ5w/DgsJFy0ICJUIiMhuC2l97G0yijFy2dViOhzMLgx0im3/vUwGoxISDZaZhAAFkzGaDWFbW5VpziGUJPhktI5QxiWkcXkIwjb9K2lmaWYzvZFoWAlncmrsoWWeC/CjFipMaV083cmAgYPe/GTO5HJErgTmy5J8YMiQVUfS0MwnPyTI7nDszi/93KJYHTTSgIoGnQpPGpCVL4M2fmsDlxtLTAkvoDSnY5olIDjbtn4GmIUbrzAE0F6zNWlMUkYmkXetMb4YVX6AJN2lvxCvxjFO/JGDsjK/6bT+n3LBnv0uYVofZEJT5N6B99q0yunJVFU50Grdb82+NEF4MRYrxrfVOV0+eJpv9CGRGg2IX/74oA/9mOVf+zLPu0MrCFy5zjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199015)(52536014)(478600001)(8936002)(7416002)(41300700001)(5660300002)(2906002)(38070700005)(8676002)(316002)(4326008)(86362001)(76116006)(66556008)(66446008)(66946007)(64756008)(66476007)(558084003)(6916009)(122000001)(54906003)(38100700002)(82960400001)(55016003)(33656002)(9686003)(26005)(186003)(7696005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M083L25hcWV5bEVnMXlSRVNBV3pzU1RsSGZ0c1RBV2kxU1VFN0I3bHRWaERi?=
 =?utf-8?B?S1RtOE9zQTdlQXN2ZzVxckt4YVU0ajVEOW41TTRZMXhuVzFXZTR1L0M1RU85?=
 =?utf-8?B?YUt3TWQveUFhZDdBZTN4MG1TZFE4ZllTV0JHeGpPUnJWWDk0aWY1eVA3NXhV?=
 =?utf-8?B?M0x6YjJHUjVhalJKYllqbUl5SGVQQWJVUk8yZForZ1pIS2l5LzgxQnR6NW1J?=
 =?utf-8?B?TWxaSUs5NHZTRlAwWm5ObFFHZkswUjk0eEhIK29GdXRESXdlaFFYakRlOXl2?=
 =?utf-8?B?V1ZxT2Q3dFVxaFlUbVM1VkFsaG9ZL25ZQXdKTkVYZDBqREpMcmpHczBrZzVI?=
 =?utf-8?B?L3l0cUV1RDlUWFRYSHkxdjJUWG1SMnFxT1U3OGRpem9CMTRiclRNNXVJYVA5?=
 =?utf-8?B?RlhuUDQzaGRGNVZXQVB3b045MkVFdFE5K3FLWnZCZ1JiUHdwMEEra1BVNmc2?=
 =?utf-8?B?V1R6aStQM1YzUFJVRzVUK2ZEQmlIUVVjTXI0dU9tMlpDUmtHOW5PL051UTFk?=
 =?utf-8?B?emE2Sy9Tc1ExcjJucWZmdHVoS1NRa0ViTE1CbEhYVEs0NUd4L0EyRlJJdVho?=
 =?utf-8?B?SnM5ZVJCeUxZYWRMVWMzUGpGeXNQeE0xUXJJZmVPa2VzdXlQeWhPZkhRR2Nq?=
 =?utf-8?B?QjVNZXhNcVFWSEdvODBXNUNGNTcrM24wQkM1dUR1MFZ4c0RqODRkWEdXYUhY?=
 =?utf-8?B?cVBKK1BaWi9pMjAwRjdtNG94OWtYNEN5YUxrYmsvTEgxRWpCNnQyNFpqTitM?=
 =?utf-8?B?bmdtWmtkT3VmaytGeTZ0QXpFb3phWGI1Tk5nUWpYcW5jOWc1T0RYTXdUWnFC?=
 =?utf-8?B?TlNmNWhEQVhjMGZNZlNWcjB5Zi9hSjl6MTRaOVVRLyttV202S1YrcGlwNzcw?=
 =?utf-8?B?RDJUbmpheTU4MkJlSjcvcVVhaFRYSVRGOTlOTHpqaGkrSHBUZFBGS3k4d2RM?=
 =?utf-8?B?cE14aDVCSG9lcjZRZnI5K3g3REF2b1MyQWM0c2o4NEtlSm0zRjRvUjlMUHJs?=
 =?utf-8?B?WEkxYnAvajBhVm0zMkF6MndNSEZNWW15d21mU2twUEs0Nk8rRzNYN0x5dVlK?=
 =?utf-8?B?ZGYvOG9KYThwdjVCUEh1T2Y1WGZsVklDYi90RVdsT3hSYlRabXBsNlNBUzl1?=
 =?utf-8?B?QXN2REpBVGxRWm9lQ0VSNkJOY1pIWDBoSFBuMi9qT1Y5amIzTWd4bzNOOFVO?=
 =?utf-8?B?cGdQMmV4ZUxDUEZyYW92Vk4xSmFma2hYZ1dGdmRYNUh1S0ttTjYvYk1naEtt?=
 =?utf-8?B?TGN5aEpMRi92N0ZQZ1BTa0x1SlFJRExvQTlhVWdWUUtiUVdINzVpbk1zZXhj?=
 =?utf-8?B?ZG9sR2F0VHU4SnVPTXdCYUhzTVRkQkJhbGxBdUNHSUZYR2k4YTh1dTNYQlFI?=
 =?utf-8?B?YkUxKzQzTEtkd0l6Vk1rMW9jbk5hQ3VBSzhxNkZCNnROemcwcFBQQ1NlMEtO?=
 =?utf-8?B?ZTU0ekpnditrWWFrSU5NMnFCY1JpdEVpMk9hRE9UbnE4UXM1SXBxa1h0WW9X?=
 =?utf-8?B?eWE5WStnTUR6UUFFdjBTNjg3a2t1bGhkby9XU051SkFjemQvNXpCeXYvNk9L?=
 =?utf-8?B?RHpvaERHSlFESWxiUDdBRlVFalRkM3BzTmVDRHRiYnIrTC9oYVg2bk42U1VC?=
 =?utf-8?B?d1dzS0EvU09ROGpYeTI0QldWOTdTNVk4bHJlblRtU09aVjM4WkFhY0tlUU11?=
 =?utf-8?B?QXZXNHhORHhpaUhGWlFtVFYrNzRYQTFaL01GY2ZtQkdKcEtKNFcyMlE2dVkr?=
 =?utf-8?B?b2xyNlYwclFrQUdMUkRGczUrcnBnYU9vMVBXSnJSV3p6RG5kcGVoWFIrOXhV?=
 =?utf-8?B?QXRqazg4UXNlK1VRV2J4RDhUcTZtS2hIREJ1MWhYQ0Y0RnBOTmZWSlJRZVJt?=
 =?utf-8?B?SFNoK1hQSGxrTE03bmNoakkxbUIyb3pRTS9NRnVvZFM1dHpQYlgyTTlhQUli?=
 =?utf-8?B?UGk5UzREMjNqMFRoMGNGQW1sbkFLM29aWEl1K0xJQTZvejBHN1BlM0h3MFlU?=
 =?utf-8?B?WHg3VmhJNks1UVNPZEM2S0VpMVR1SkVhUnZKZDZXcE9QRGVKMmtXd3lXQXFt?=
 =?utf-8?B?c1k0dUl4WnF2RFBScVpTTkJBcklWMkN2WmNZcEdzc1ErR2VOVXlldjVJbVdV?=
 =?utf-8?Q?brYE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db93d2d4-5bb6-4600-774d-08dad57cb20b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 22:21:16.5634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2qG7ZCakkkuAum5YzL2/ovAtt/2lghgzRGGPjqkgAN2WxDRHDoOusMrhNMb9a6t88MM+MwbF18WepuCWmGhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5031
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBGcm9tOiBYdSBQYW5kYSA8eHUucGFuZGFAenRlLmNvbS5jbj4NCj4NCj4gVGhlIGltcGxlbWVu
dGF0aW9uIG9mIHN0cnNjcHkoKSBpcyBtb3JlIHJvYnVzdCBhbmQgc2FmZXIuDQo+IFRoYXQncyBu
b3cgdGhlIHJlY29tbWVuZGVkIHdheSB0byBjb3B5IE5VTCB0ZXJtaW5hdGVkIHN0cmluZ3MuDQoN
ClJldmlld2VkLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQo=
