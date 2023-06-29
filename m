Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247D67423A2
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jun 2023 12:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjF2KDl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jun 2023 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjF2KBk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Jun 2023 06:01:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1853C14;
        Thu, 29 Jun 2023 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688032737; x=1719568737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6ceAx/fYbTbTqytdQbKZ7/7A0VuAA4IOJ+smzNJyDFs=;
  b=EN+T2IIr9HSlJnFqpGLBwY1bG0npD+aN3fQHwX9aOHfT0nvCdDupg1kY
   yNa4LWA0ieP+seB/nsZO9e52ZhRtdmmBlGvWmnQWg532r3HS7XMzxz+a9
   rLjNle/X2VKRHjT/0s/CUxoFHv+UYXV21pjAs23jcTAXkWIJaL5XY3VDw
   X1XoCXgHtO6pQMF3x+Mf39p5R06tuCwy7m7SiNTjs2JwBc9s8fkMXOJHW
   ElZ1DHkXq2P1q7HqydPGsGvq8JCGYcllNJyXpuAq9p+Hq58y0TFuX3F5Y
   zPoyd6nycp2HfAoMkUibaPDKAM52AuRtZcg/VjdlxgrxC4/OESz/WrZlb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="362107763"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="362107763"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 02:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="807251227"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="807251227"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2023 02:58:56 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 02:58:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 02:58:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 02:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4GLJ0YYSVLI13PhCol60twYdTQI67L/h/5bWwCTLkAtjM9OqfjXFbaQayaYKe+MtCuR5lPP+4WtGA+aAMXOPGWEqnQsmtRMJKTe8MJ7+EdmJvgHjfbhu4YlY0zBMByg3ECsgED5IPr+dRA0/CJ+SqqPr3jvjUvClY+ofR2kjfXj3u9Fl2/M6WSepTAHr4ZVqHxzNCD6E7REJc7cg9lSwnS+1i7MVhzSgUkXaDeeKbSXD+0/x4bE0OSKoicAZmrY4yS1GOm2hdfg/fo04KZQDi4wC7itQcmtUgTsWPnt6IU6lMvgKGnFJprYnsU6pfxxISafwFBnDm69tJuCvx9cyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ceAx/fYbTbTqytdQbKZ7/7A0VuAA4IOJ+smzNJyDFs=;
 b=CTwWUUfeeMzxG2VtkPJ3Mgn35vxBkqd55GHRjoNSM7hLpJsnwzspCvq3W5Eugd2nFhDFh99aa8b07pYIPdhbEgnyrXA6loYAPzCywgmDzQpLmkD0cFY70W+uPGftwzHIUUP5+D9RJ0tQ6oo2AhR+QZBqHXfR3GlylQPsSbBYvnDRpHJG3DdxcWQROeflhroiHwHwclUFHQsOzq+xcFMtI4XtSoFGfsyXjJFUNb4vcHTHrl1dijfGEQMhoFKm1AFIX5PqS8rF3o46GcIQtcfdFiBuvK2FTLdblC9AOaYiLpoMBX7D6Q0tupqYWb6KglcUGk2Nk97D98spUKX7RUDeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA1PR11MB7726.namprd11.prod.outlook.com (2603:10b6:208:3f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Thu, 29 Jun
 2023 09:58:54 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::dbae:c83f:2e61:a5da]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::dbae:c83f:2e61:a5da%5]) with mapi id 15.20.6500.043; Thu, 29 Jun 2023
 09:58:54 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Koba Ko <koba.ko@canonical.com>, "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/i10nm: shift exponent is negative
Thread-Topic: [PATCH] EDAC/i10nm: shift exponent is negative
Thread-Index: AQHZqaGVpIqT6jxceUae4/C3IJvH+a+gawgAgAC7+YCAAFsz4A==
Date:   Thu, 29 Jun 2023 09:58:54 +0000
Message-ID: <CY8PR11MB713480F6D06D11BC4742AA0E8925A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20230628085253.1013799-1-koba.ko@canonical.com>
 <SJ1PR11MB608340E81A15F20EBAD75F08FC24A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+U7Af3ypru3O0quGTqrsJPMO3b7uoBTNjTLSixrmrvXJw@mail.gmail.com>
In-Reply-To: <CAJB-X+U7Af3ypru3O0quGTqrsJPMO3b7uoBTNjTLSixrmrvXJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: tony.luck@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA1PR11MB7726:EE_
x-ms-office365-filtering-correlation-id: 8bfb9e84-afa0-4040-68e8-08db788772a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTlztJQWcuJZbdC05HX9CMeT5DNoxdrWLMKYxvTmCyeULcFk2gkqfRR5pFMr7sQ2+Af7mwVztezX+GfXYCwh/EszDN2w2EABoWqGiXk/ZojjqIIC5vfUChgIBatup0K5b4JAJeRygAqz792fZOZ9qRTJFUGFNwShUxsriXtf3m6yA+mQSRlOZnlTeTxpUFAfAu6p7xCM7garyRd8XqyLq+hhS8/2JnHIgeWGm7In6OBHyKOjBWL6A6sd1elp20csBSd+uT1rLPQycXE9sZgo0BLQWDYyug2IPLiW3tyMEPAv3rdJfcC4WtLq6GjPWuDtuBkaPzdZGqwfMqgjUK33qNngUsWVWKT6mwfYPqEpw4x3KGxQzQqj3Qms+zVERAtD6L750RBCHdpwr9wm703RPG5HOm298tuQQCRDJbrUisp5xzFC7nHnwiS+8k1gyr9CbDQOTR6+unT+mB6QILNsTju0RW9UZkrnooL0uoomV9gzKS4sCwkQeqaKBjBYdzyn7+uqcKeSxAlThuCwrKBB/jRLs5glIpr2NZDUnMT70jj3gDnymg0fehaU2mnAy8iyA5P+K17cleLg15Qs3TjRtA6K8j1y9akHWlxEO2fmHZ7J8AZY8gVGt83K6QJFB+OS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(38070700005)(52536014)(5660300002)(33656002)(53546011)(110136005)(9686003)(54906003)(478600001)(2906002)(8676002)(8936002)(26005)(6506007)(86362001)(55016003)(83380400001)(82960400001)(7696005)(122000001)(4326008)(66476007)(6636002)(76116006)(64756008)(71200400001)(66446008)(66556008)(38100700002)(316002)(66946007)(41300700001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlhBZkk1K2hNTjMxTU1Ia056aCsrZitRUFk2bXdnVXRjcGJvYVJxTEMrWmRj?=
 =?utf-8?B?aDVKc2V6Wnp3R2Y3ZERCTjZ5NklXWFc2bEdTdjNuNE9yYSszMDRoMHJsVjZP?=
 =?utf-8?B?NkNaTXJDSmM0cXRXNEF1MTNuWC9aM21oOEdSc2F2SElZc2xraVp2eXdCZ1FI?=
 =?utf-8?B?MWFEYm1pNW1Ld3RVd0FyM3ZaVVgyWUU3cWRoRjlaakFRbUVTMnNNZGthWGpN?=
 =?utf-8?B?azRNL3JiSXFDOHRwQzI5OVU4ZmNTNnNENU52MHprZzIwR0hIclhuc0k3dFNJ?=
 =?utf-8?B?amJKeFRNYW92eEpkblo2ek5VcWh0L05keUxrOVZmdGlUTkZ1K0liNVFJblpH?=
 =?utf-8?B?UnQ1N2wrOC9vQnMycmphSzBUeGticksreTAxVEsva0x3dEM2YVZoZUZWVmZ3?=
 =?utf-8?B?T3gyb3Y4NFpVSHk5UktaY3lpakp2OXNFWDlYNHVLbXZjUFU3VlpJVlZvSnUy?=
 =?utf-8?B?WG5VVjdtSUVuNytyQWppdC9hejRGbHg0M2hjZDVZWXlwM2xpN3BwTW9sdnZ0?=
 =?utf-8?B?V2ttTEZESHhQQlN2cHVTaDYzbXJlOWM3eUZqWUJqTEVWSE9JbDZzeFJaNmYr?=
 =?utf-8?B?WFdaUWo4VTByajlBdGZXcW1Mb1ZvMnU3QjZVUVVBajkxZ1dWaWc5ZGpUcGc3?=
 =?utf-8?B?QTFsRFd4ZmJyRWZ2NHd5d1IyRnA5QWtWREVjNnZmVkZFNktaK2JHZktwQ3B0?=
 =?utf-8?B?NHR6cW4vMEFadUxqSDY2THNWRTdJQ2JMOFYvK3lRQ1UvNlFITDZzME9OZzBF?=
 =?utf-8?B?KzgvRVpHTFhOc1BuWVJCNXpmc0pZU0sxYWRERnBXblJ3dG1BaFAwdjN1bTFM?=
 =?utf-8?B?L2VjZStBRXlOOEhsY3VhUjQ4aVpYSGVPbEdJZ1RMTk54OS8wZjhxalYyOUc4?=
 =?utf-8?B?QzVVcjFaSWlMSW5FbW1aSWcvUGpzK1dyMUhNQXA4ZmxaUzNaSENKTVNxMERY?=
 =?utf-8?B?bjRWMUlnSFNacmF6THpzKzNmYWlOamNWYWlrVUVUbkErbDNIR09hWTBzNzli?=
 =?utf-8?B?YlpKbUFKdFA4amREaG9PcWhiazBlbU9KMjg3Mm05bGdDR211YjBjM3dFMUlZ?=
 =?utf-8?B?WXRpRE91OUpiSnBWajRDbjBBVXVnUGdqSjBxRDUweFhFc3A0bS9LaHVhNlBt?=
 =?utf-8?B?MDVnemxYNC9Ccm91M0c5enkvZ0xsdVlUU2xPUW1rdTZGMTZsMlkxWFpad1cy?=
 =?utf-8?B?dW9MdzcrMkJtQVNVSjZ2QlJidTJCRlZFVndIK0Y3SHRTb09PWXZmdm40WDhU?=
 =?utf-8?B?Y3U2bGZpM2RpTm9yai9nYWd6dHRZMGdkREpCYjJ6WjNmZ0kvMVcyS0kzWTQw?=
 =?utf-8?B?cUJ4TkxVc3QyTm1NaUNnR3ZEenVLS0QwemlFbmdmV2ZmdXNhQ2RMT2oya2hD?=
 =?utf-8?B?NU9EbE1nMXMyVVFWaWw3RXJOdUYrZ2YzUzNUZGRhcVYyRC8wc2tKaHlYYkdo?=
 =?utf-8?B?WlNqY214QXpHZEZzSXFhbW5zYVVlMEE1bEZPL2N6WEl2bE13aURWeXJSSHRP?=
 =?utf-8?B?b2RQYXRFR1JLSTNkckhqWXB1eTFSWXlsUFR4azhBMVpoVGpPWndpLzJjcnMr?=
 =?utf-8?B?V28xc1RCekN3MzdDWFkrOWhqeUluSHZYQ1NmN0JWbnBJNXlvQnVVa3ZCUEQ0?=
 =?utf-8?B?WGwwM0JCMDdqdjFCRU1kdnFNcHpLT3gwYldSdWticWsySVFrVDZzTWswUkw5?=
 =?utf-8?B?cUJSQkRRcCtHUy9RcWpBNWFDODZtWDBPWnpzOUN2cWdUb0dNcmZ2N2xEVUc3?=
 =?utf-8?B?anBLaEdrL1BPUXE4WldZbjM2bWx4dlIwdGFaNUJERXhNU0Y0clZ1YWpkbTI0?=
 =?utf-8?B?ZFpVRlBqRXEzREpqc1VLZHJSYTNJWkNWb3lUZlZ1MEtpVWdiUE54NlZFZVpW?=
 =?utf-8?B?bXUyZ2p1a3FCYUQ4NkN3Uk5MZEhuY1VuVzYzR1ZnRTk0aEk1WThvTzY1Rm54?=
 =?utf-8?B?WmF6Q01zZVUrTWhWeE5pclZncXAvT1RRYVpSVGw1R01jYSszSElEK21JbEpy?=
 =?utf-8?B?Vk9jMERSQkFxT3psdmQ1cy9DUXZUdDN2cXY5YjdpcGlTaVlDdzgvMHZGYnFo?=
 =?utf-8?B?N0tQMUd0dk1Da3FOS1B5R1BWdlROUEs5ZmtBb1RFVjlsTkVUakcwMjhSOFNr?=
 =?utf-8?Q?THkO8QlJVuuipgqubqCi/YYWO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfb9e84-afa0-4040-68e8-08db788772a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 09:58:54.1728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmWXLR5FBYwka/oVQ2M/Vj4ufccjerwGYcX8B3e0qrQcwOJhwg15aeOy760xzw2rzeY+5p4HlGuUEHnciL8L1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7726
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

SGkgS28sDQoNCkkgZG9uJ3QgYWdyZWUgd2l0aCBzaW1wbHkgc2tpcHBpbmcgb3ZlciBhIERJTU0g
ZXZlbiBFREFDIGRvZXNuJ3QgZXhwZWN0IHRvIHNlZSBpdC4gDQpBcyB0aGUgRURBQyBkcml2ZXIg
Y2FuIHN0aWxsIHJlcG9ydCBlcnJvcnMgZm9yIHRoaXMgRElNTSBvbmNlIHRoZXJlIGFyZSBlcnJv
cnMgdGhhdCBvY2N1ciBpbiB0aGlzIERJTU0uICANCg0KQXMgcGVyIFRvbnkncyBzdWdnZXN0aW9u
LCBjb3VsZCB5b3UgdGVzdCB5b3VyIGtlcm5lbCB3aXRoIENPTkZJR19FREFDX0RFQlVHPXkgYW5k
IHNlZSB0aGUgcmVzdWx0Pw0KIA0KQEx1Y2ssIFRvbnksIFBlcmhhcHMgd2UgbWF5IHR1cm4gdGhl
IGRlYnVnIHByaW50DQogICAgIA0KICAgICAgIGVkYWNfZGJnKDIsICJiYWQgJXMgPSAlZCAocmF3
PTB4JXgpXG4iLCBuYW1lLCB2YWwsIHJlZyk7DQoNCnRvIGFuIGVycm9yLXByaW50IGV4cGxpY2l0
bHkNCg0KICAgICBza3hfcHJpbnRrKEtFUk5fRVJSLCAiYmFkICVzID0gJWQgKHJhdz0weCV4KVxu
IiwgbmFtZSwgdmFsLCByZWcpOw0KDQpMZXQgdGhlIHVzZXIgaGF2ZSB0aGUgY2hhbmNlIHRvIG5v
dGljZSB0aGVyZSBpcyBhIERJTU0gdGhhdCBFREFDIGRvZXNuJ3QgZXhwZWN0IHRvIHNlZS4NCg0K
LSBRaXV4dQ0KDQo+IEZyb206IEtvYmEgS28gPGtvYmEua29AY2Fub25pY2FsLmNvbT4NCj4gU2Vu
dDogVGh1cnNkYXksIEp1bmUgMjksIDIwMjMgMTE6NTMgQU0NCj4gVG86IEx1Y2ssIFRvbnkgPHRv
bnkubHVja0BpbnRlbC5jb20+DQo+IENjOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47
IEphbWVzIE1vcnNlIDxqYW1lcy5tb3JzZUBhcm0uY29tPjsNCj4gTWF1cm8gQ2FydmFsaG8gQ2hl
aGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBSb2JlcnQgUmljaHRlcg0KPiA8cnJpY0BrZXJuZWwu
b3JnPjsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gRURBQy9pMTBubTogc2hpZnQgZXhwb25lbnQg
aXMgbmVnYXRpdmUNCj4gDQo+IGhpIEx1Y2ssDQo+IEkgYWdyZWUgd2l0aCB5b3VyIHBvaW50cw0K
PiBpcyBpdCBleHBlY3RlZCB0byBzaGlmdCB3aXRoIG5lZ2F0aXZlPw0KPiANCj4gVGhhbmtzDQo+
IEtvYmEgS28NCj4gDQo+IE9uIFRodSwgSnVuIDI5LCAyMDIzIGF0IDEyOjQx4oCvQU0gTHVjaywg
VG9ueSA8dG9ueS5sdWNrQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+ICAgICAgIHJhbmtz
ID0gbnVtcmFuayhtdHIpOw0KPiA+ID4gICAgICAgcm93cyA9IG51bXJvdyhtdHIpOw0KPiA+ID4g
ICAgICAgY29scyA9IGltYy0+aGJtX21jID8gNiA6IG51bWNvbChtdHIpOw0KPiA+ID4gKyAgICAg
aWYgKHJhbmtzID09IC1FSU5WQUwgfHwgcm93cyA9PSAtRUlOVkFMIHx8IGNvbHMgPT0gLUVJTlZB
TCkNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiBUaGlzIHNlZW1zIHRv
IGJlIGp1c3QgaGlkaW5nIHRoZSByZWFsIHByb2JsZW0gdGhhdCBhIERJTU0gd2FzIGZvdW5kDQo+
ID4gd2l0aCBzb21lIG51bWJlciBvZiByYW5rcywgcm93cywgb3IgY29sdW1ucyB0aGF0IHRoZSBF
REFDIGRyaXZlcg0KPiA+IGRpZG4ndCBleHBlY3QgdG8gc2VlLiBZb3VyIGZpeCBtYWtlcyB0aGUg
ZHJpdmVyIHNraXAgb3ZlciB0aGlzIERJTU0uDQo+ID4NCj4gPiBDYW4geW91IGJ1aWxkIHlvdXIg
a2VybmVsIHdpdGggQ09ORklHX0VEQUNfREVCVUc9eSBhbmQgc2VlIHdoYXQNCj4gPiBtZXNzYWdl
cyB5b3UgZ2V0IGZyb20gdGhpcyBjb2RlOg0KPiA+DQo+ID4gc3RhdGljIGludCBza3hfZ2V0X2Rp
bW1fYXR0cih1MzIgcmVnLCBpbnQgbG9iaXQsIGludCBoaWJpdCwgaW50IGFkZCwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGludCBtaW52YWwsIGludCBtYXh2YWwsIGNvbnN0IGNo
YXIgKm5hbWUpDQo+ID4gew0KPiA+ICAgICAgICAgdTMyIHZhbCA9IEdFVF9CSVRGSUVMRChyZWcs
IGxvYml0LCBoaWJpdCk7DQo+ID4NCj4gPiAgICAgICAgIGlmICh2YWwgPCBtaW52YWwgfHwgdmFs
ID4gbWF4dmFsKSB7DQo+ID4gICAgICAgICAgICAgICAgIGVkYWNfZGJnKDIsICJiYWQgJXMgPSAl
ZCAocmF3PTB4JXgpXG4iLCBuYW1lLCB2YWwsIHJlZyk7DQo+ID4gICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gLVRvbnkNCj4gPg0KPiA+DQo=
