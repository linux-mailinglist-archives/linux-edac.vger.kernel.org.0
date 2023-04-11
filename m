Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC46DE07D
	for <lists+linux-edac@lfdr.de>; Tue, 11 Apr 2023 18:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDKQIm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Apr 2023 12:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDKQIl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Apr 2023 12:08:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7691FEB;
        Tue, 11 Apr 2023 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681229320; x=1712765320;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V0w8KFGOUFcOxKOBZyTc7sivpF+zjpMHzl9EXOpytHo=;
  b=Yq7Z1OBEzl/Vgp9bOK+0TdISR+tltYwzDMhWFVpGPYAGiUaO0gTexEEQ
   SsNezFcXpC28xPEnisEFuAU82Ljeu2H9cDyOmPZnoSFP6JupjxG1APEeE
   KBGa02QP981e5FTlec9wwWl5ysP61+N9rrY8spiSjRqf3Wy0ARr/jW501
   OtT3cW8nvEmUQ/bS3QYv/EnwjPB2o5ltLbnO2kCnZ5QXCItknM3xYwzNo
   C/sco9QFCXjXnGxAX3EPI5osmrl+FRcxi0rkogJbsHasVWl4OmLj8/6ga
   OsV5bMCS+wERQ5ZswDiu+fQhwAOBsQ2eldC4HLinZgitZm/lMU6bn8LLu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="332346617"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="332346617"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="682129634"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="682129634"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 11 Apr 2023 09:06:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 09:06:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 09:06:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 09:06:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 09:06:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5IJ0kJYInfnEksj4Mz9Kx+FTh73NI6MnagvR842NTFMyEvQbOp8YEt9rgO4OnAgttV6hGZTGUBGzz00asYE+McImFKSbv8+/4TjCyGgLZD6ZDnJFxCMp6dMGwsN+YH0PchpfO7MBn/jbPqkmNRvnpoAkw+hUpIL3ikDtFFtseObQoa+YIlhk2RD8O8UdZtvRDFeTBZ5CAp35lnZgQwP1L5Jzjs7oS6KGiPr7q7ewZKtjAWYvafCVOyggxwwGxx8ey1BPss+YC6MQpX6by6WktJFrQuOgc/kwjZTw3EpTLGHNLtbkrCQSJPDcBB+VcIFgHNfYCN1SF6LtN96P6HPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0w8KFGOUFcOxKOBZyTc7sivpF+zjpMHzl9EXOpytHo=;
 b=FMUzQeG0/UBgpdqTFhnrRqeXEEeQqz4f50aZTbhqtzl64MNhBH2RMGbwSyM5KG1KdN66wUXqWDh2uWQx4A8Qt4TAa4oXZPTnNtQ04Sm8Q6K/74gJUDvs2VJmAWIvaPkXAsfPDHOlcfxun9WDWp9RBaG8MdKCdu4fYLr1pjwxgUZDl7qUMHcJLjNBhl1lVHUnn1halt2RmRvqjDT/FY3FeJn78UYIWJ3M75nmaf+kp+cZ8SHcK2rwEkC8Y7Betb+AkQ4uxNW8BezXjDTJzrgAPPEgKR0jJKkhkIsdZlRzCXdrpTEQQY4rYvmAao8Mr53Y/62z0X4Y9zrSX2vNsJFZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB4814.namprd11.prod.outlook.com (2603:10b6:a03:2d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 16:06:17 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f801:5faa:7a43:309e]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f801:5faa:7a43:309e%4]) with mapi id 15.20.6277.031; Tue, 11 Apr 2023
 16:06:17 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v4 2/5] x86/mce: Add per-bank CMCI storm mitigation
Thread-Topic: [PATCH v4 2/5] x86/mce: Add per-bank CMCI storm mitigation
Thread-Index: AQHZZnBTMledMMB5KEiKOs/HeSzMTa8mFoEAgAAaUICAACCRoA==
Date:   Tue, 11 Apr 2023 16:06:17 +0000
Message-ID: <SJ1PR11MB6083508C64838C99F4C103C7FC9A9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <ZCRYl9c7xgIJ+pJe@yaz-sghr>
 <20230403210716.347773-1-tony.luck@intel.com>
 <20230403210716.347773-3-tony.luck@intel.com>
 <20230411123234.GGZDVTYppLWRN5t0jX@fat_crate.local>
 <6b6e53c5-8562-8ea0-befa-88c8b38663d6@amd.com>
In-Reply-To: <6b6e53c5-8562-8ea0-befa-88c8b38663d6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB4814:EE_
x-ms-office365-filtering-correlation-id: 020e8ca0-ecee-48df-43c7-08db3aa6ae98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7gTd6mDdwarHn1oGG5AmCGUsNyDvA9hE9sp5gHbuH5RV30BpUg01ibpAbrf934YqtVFa6FBsoStrZqjR2ippQL8hb7gvBr1m9rt1AKnAeAtXHQFekf1nalA5h/+iOnT7/zmQKAh6bRaKbpWAIautETCB9AoBmbl3iKTM7ICWN+jtnSbhiL+mWbfm8ROtqoCvcBghemmctNAh3uYHjxDVeqw0G0/fpwIxSMVezqTs+LUSPw7zuy7lPejkjOOafob9YbW592nwXlKZavOJllYNtHnlK7mFumv4c6XcIjEFAwD4vosSQavZWrAykr2jdkHeuZ9MiZEFJObIHa7MKgbEzUdYCuYTPCUi16IWm62h2lbmFddFh/S1y60uflyvZUznx22+/SmcOij9LK0DtTqJpZgZ2ceXnytss9IYFTbvH4SyC+2bMAH7ZIn30VYWe56uMe0U3oEdvpoX62ESHPT1AEzSpHF9gSEVHliD4z8Kdsptxs0Q+rEMxxG8pv6pwrmuLwZ/RXG2Woj9P/hYRi9t5tfcRrkGRUqaLAG4MYoC2ze2jRq4cmX/0Qpto6OqQ3GZtgahpdjTKjlQTC1pV9HSNhEo+AA6v/q3glMp5v+/0E3h2++Zzzt9SrBgLcP/kwD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(7696005)(71200400001)(478600001)(6506007)(9686003)(316002)(110136005)(54906003)(26005)(186003)(66476007)(2906002)(4744005)(64756008)(66946007)(76116006)(4326008)(8936002)(66556008)(52536014)(8676002)(66446008)(41300700001)(5660300002)(122000001)(82960400001)(38100700002)(33656002)(55016003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODMvRFp5VUNBQ3gxZjNBUHozak10K05zOGw0OVlmQy9ndGxDWHJSUzUxQjVj?=
 =?utf-8?B?aTRzd29ibEZQcUZmTVpZOVlWc3RYbkt1clJLZitmZFNmSHNLOGxYUEU4d0Vm?=
 =?utf-8?B?TDROT09jRElTNG5Lb21sOW41VHZZRmc1aVZ1VnpzT0ZybHFZelNyM0NSYU5n?=
 =?utf-8?B?eFBXOXlGUlF6eTMyK2ljZ1NSK1J2YStRQU11V0JyWm5vd255WFZUd0hFU3R4?=
 =?utf-8?B?bTBLNHovdDJvUGNUVko4dFhWbXZBZVQrNFFUSFJkS1Z0cG1lay9La1J1TTlU?=
 =?utf-8?B?aTNlb2w4TW5DM3NaS3B0QkZ1T3QzZ0g4SjkyZFU1RjRrVUxXd3lIMU5kcFh1?=
 =?utf-8?B?bzhVS0hBeE9UeTdicElVb2JGYjlWYlgxL2F1b0lISVNndW53cFhIQnkwSTFY?=
 =?utf-8?B?Q01UQ00rOEFUWFc3ZEsyVmVuY1BqekpOVmt0OVcrdlE1Vk91TjZwZTUyeDli?=
 =?utf-8?B?R1VvQ09TcnBKandaSk1qTW4wQ3VUbnZ1ZmNNa0doc2tReE4wYWo0dzRQcWZx?=
 =?utf-8?B?Skh6eVllVmhFRkxxaHBKWStQeDdlS0NzVHEvVXZZQklqSmhIajdVZm80bElu?=
 =?utf-8?B?VzNpUEtyNEErbzJsZW9HYXBxZWw0N0QvazYzcFlVS0FGLzNaVGFSbXBBQzYr?=
 =?utf-8?B?SlExQ05rNUU5bXd6UWplRSsybjJLNGtXS2ZNdm1PdlZmSjdvd2pTQmpuR2Ju?=
 =?utf-8?B?V25EM1lvQTV1VnZkT291Y1NWSTNQQmxCY0tkZFZOeXphSlplbmY4ZFFWOCsx?=
 =?utf-8?B?em41TE5NeTVja3hoMDdhMVdnUFh4UTlkUUdTbzJMMmYxZ3VCN0FOMm5jWlQx?=
 =?utf-8?B?ZHBLcFlUUDlrNUR6UmsvWjVweWVVTXFWY1pDd3J5eGFyQ3Fsbm9tNmRLVGpW?=
 =?utf-8?B?bkxoTTNXWXR5bkxhUUk4VllJa01XajRMVnA1YUZnbnc2RUt3RzhhSzBqVVd6?=
 =?utf-8?B?NFpNNVV6U295RGYvVTlXRkJRN3dhUVpnUEhSRUpUTDR5MDVsbERkOXNkWk5Z?=
 =?utf-8?B?VVpqTG41YTIrMTVQQ3VWV0EzZW5oNmMxeE1kd1RoS25RaTlQSndZRW9ydmI3?=
 =?utf-8?B?cEZqR3RFUG8xK1N6c01LMHQ0TmVLYjhHeGZ0ZXZjUUQ1Z1FUKytiNmpDcUtE?=
 =?utf-8?B?TDU4a3VuMlg5TE9qdVNOWTVIbzF0cFBKdWcwRm9xemtKdkZ3UEI5bWdEbTB0?=
 =?utf-8?B?VWt4OHJFNHpsY2JrRkMxOWhjeG9JYThOSVJIckRZVHBWT2o4a2JoSlV2dXdl?=
 =?utf-8?B?Z0U5UVRxY0pqRGtYZ1dGR20rWFYvZ05zaVFsQ253NVYzYmQ3U052Tlp4d0tL?=
 =?utf-8?B?M1V2Zm5XZnlIakxDd01vZ1FnZW42NE9sS2o3RWF5ODRuWjZSdk1TY0hGeEQr?=
 =?utf-8?B?cEtrQjNnRFB2WFhzbGl0RmNQbjZzeW96U2c5ZjBXTlByZU9hZjNUSk9oa1RX?=
 =?utf-8?B?VStNT3A3RitxTlh3YTV1U3ZtaWlnMFJxdEZQUjBqenNFYmR3ek1BVVp6aTZl?=
 =?utf-8?B?cE9zQkhjeU05RkVOaVZ6Y1A5ZWJVOGJBWURrcHQ3eFhEaG40SlovWXByR2JR?=
 =?utf-8?B?dEVTOW1UeHQvMlNqUHRIZk0xM1BkR201dXlNbXY1dnZWRDA5MmhqOWZxdGt2?=
 =?utf-8?B?WVRqTjZBRDlPTDNmbTljaWh0Mjhza2l2ekRlQTBsKzcrN2RXZDNEK3l4SzlH?=
 =?utf-8?B?NFI1TmNOZlp3R2pQb2RsOFNMNzF6TTdnSDRiUXpEVVE0TVVhMXVMZVZWb2gv?=
 =?utf-8?B?UFBXOFlUWDFsVEJvQjZQQUsrN2F4d1NqcWsrbnBZd2J4UWFrQmtZdlV6dzFs?=
 =?utf-8?B?VEZLeFUwQzVZMVpMQTlhejkrVlJOc2ZQeEVNWm16SVB1S3VHeDhxQkpHSTkv?=
 =?utf-8?B?RThYay84UndyemcydW41WUR1Z1NEdm5nN29HRmFCNHpEM1FGS2NnbXdKam5E?=
 =?utf-8?B?bk92VmxTWWY4TUhXbDBCSDJhck1RK1R1ZExTWXpoRmpzWWhyZGtYMUQ0MjZJ?=
 =?utf-8?B?bEtlTUFrOTRoRmFKeTN2THB4cjgzRm1hV2dPM2NoMENJUDQ4eHV0eGozSmJl?=
 =?utf-8?B?aXBzN2YrVjBicHVHVlR2ODdjeVAraVErY29uVmJmbFNYMXRNbHAxcXlhTW0z?=
 =?utf-8?Q?xp+E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020e8ca0-ecee-48df-43c7-08db3aa6ae98
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 16:06:17.0999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgCPfkt/pIGiQTYSfMWGvDu/VTdzf1oljsJ7KRazqZ8FXeK4CmWFXRO1b8CSXoIisSokTaAwNEJe0eXk4FZkGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4814
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiA+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGBtYWNoaW5lX2NoZWNrX3BvbGwnOg0KPiA+
IC9ob21lL2JvcmlzL2tlcm5lbC8ybmQvbGludXgvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29y
ZS5jOjY4MzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdHJhY2tfY21jaV9zdG9ybScNCj4gPiBt
YWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUudm1saW51eDozNTogdm1saW51eF0gRXJyb3Ig
MQ0KPiA+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MTI0OTogdm1saW51eF0gRXJyb3IgMg0KPiA+IG1h
a2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQo+ID4NCj4NCj4gQWgsIHRo
aXMgaXMgd2l0aCBDT05GSUdfTUNFX0lOVEVMPW4gYW5kIGV2ZXJ5dGhpbmcgPXkuIElzIHRoZXJl
IGFuIGF1dG9tYXRlZA0KPiB3YXkgdG8gdGVzdCBldmVyeSBjb25maWcsIG5vdCBqdXN0IHJhbmRv
bSwgY29tYmluYXRpb24gaW4gYSBzdWJzeXN0ZW0/DQo+DQo+IEknbGwgdHJ5IHRvIGFkZCBzb21l
dGhpbmcgbGlrZSB0aGlzIHRvIG15IGZsb3cuIEl0IHNlZW1zIGFsbG5vY29uZmlnLA0KPiBkZWZj
b25maWcsIGV0Yy4gYXJlbid0IGVub3VnaC4gQW5kIGl0J3MgdG9vIGVhc3kgdG8gb3Zlcmxvb2sg
ZHVyaW5nIGNvZGUgcmV2aWV3Lg0KDQpJJ20gYSBiaXQgc3VycHJpc2VkIHRoYXQgbGtwIGRpZG4n
dCBjb21wbGFpbi4gSXQgdXNlZCB0byBkbyBhIHppbGxpb24gYnVpbGRzIHdpdGggY29tYmluYXRp
b25zDQpvZiBDT05GSUcgb3B0aW9ucyB0aGF0IHdlcmUgcmVsZXZhbnQgdG8gdGhlIHBhdGNoIHNl
cmllcy4NCg0KSSdsbCBzcGluIGEgdjUgd2l0aCBhbiBpbmxpbmUgc3R1YiBmdW5jdGlvbiB0byBm
aXggdGhpcy4NCg0KQm9yaXM6IEhhdmUgeW91IHNlZW4gYW55dGhpbmcgZWxzZSB0aGF0IG5lZWRz
IGZpeGluZz8NCg0KLVRvbnkNCg==
