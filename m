Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5386605D3
	for <lists+linux-edac@lfdr.de>; Fri,  6 Jan 2023 18:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjAFRnL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Jan 2023 12:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAFRnK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Jan 2023 12:43:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB18238A5;
        Fri,  6 Jan 2023 09:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673026985; x=1704562985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8EZkqKx8PfABP3goFu08HPHkMEIJZQQzyPZhcv73FV0=;
  b=PGMJuXcobgbusSSOZ7MARrjbLHQwz411H8exIvnPP6Nua5GPbrO6ym94
   aQ5Vx0CP/hpHvAqkEPyphGTEYu5etUMQYtsBio7Em12vuGaYmjkQ5iCJo
   MxZrPCIENAIbV8BDRIoviXVpBeja6Pn/3qvGgGx/tsuiT07d9ScSJAv7t
   6K+87Ye4TFvQtVtLZeglN6PiCuXk34rrxam51r6jXiM1CGsjjHKP5C9AH
   W338BIe4zBNwKygWUU63asmK0l1NE78M2jNhWy1YJzc9J5VbVWVt+Iclb
   YNTzozoKv9AJlQ0BlqV0DC1GqoTcRTQTxlJwxCG8IiMEcsXcF5FlpHeVz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="321226223"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="321226223"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 09:42:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="763582098"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="763582098"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2023 09:42:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 09:42:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 09:42:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 09:42:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 09:42:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE+bYe7gr+JkzVaTjJwLWf+7+p+vqspJehoj59vOqiWOZUSFImbdRGuzm0GvnQLXXTzF6thPiycBqIz5L1jbENpo8W5RCpMlD5J5pO19tmU0kLxq2OJl+ztX1LbD/C4LX5qaNIC2jVjcPQlJ+bo9GY+Dykb16jol0Nv6GbcvbSla6pFe++PtffsTDedYVAgHbpjx1/nyhkZoBApw+jiMYg0rLB0007W4BQUEFoV2zwIWBmo2Q/d6i0Wx5bRleeBJdzkCVi+5Qu7n3DjSnrPfCYJlvs+IAqP2IpstKEwE4FatnLkIuelK+FX8Ibm2Vsu1ZxrwskKS3OMDFRFkO1csGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EZkqKx8PfABP3goFu08HPHkMEIJZQQzyPZhcv73FV0=;
 b=HMGc60Evo+v1crJRuwWDEjLGGdYKWeecwLDSMmu4y8Z7Ntb4RANhTZXk4QiHH+qlAbtgafEwmT/x2049wuFf7TJp/CU0GnM8Zyf1343Ctju0ofo/iJQ9+8R4dOlmnzDnSKWe0ScN7FP+D7ZuxuLlo0jzvSLIMlPXT7h+XhMgdABFgXL9y8oMQZaYjlf03w89HqN7VJkK87il9MFR7PVnpsZiW+XvLNQphppUQ5FbzOb6RBAOMQFSqihslJpYnTmG5TjmROFQrQkR1Cxr6/OgOjOGna1ebOqSReJMDmc8GVq/f8VU3q6pTN8On90ulWMzI77DEpaT2otPkDPhbca4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 17:42:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 17:42:47 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH] mce: fix missing stack-dumping in mce_panic()
Thread-Topic: [PATCH] mce: fix missing stack-dumping in mce_panic()
Thread-Index: AQHZBiod8rBYaoP1F0+0JAoGaAcDUa5aqxswgADD7ACAKX1GgIAACwCAgAAE7YCAANthAIAHiZWQgAN23gCAAQX3gA==
Date:   Fri, 6 Jan 2023 17:42:47 +0000
Message-ID: <SJ1PR11MB608346981E53D14BF37788FCFCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com> <Y61/+V47qH/8OVxp@zn.tnic>
 <1e97c11d-99b6-c06f-b67f-c56ba6653d27@huawei.com> <Y62NVThhnGtnj71u@zn.tnic>
 <276c9e6b-d647-6f7f-7bd1-c1f45ca23261@huawei.com>
 <SJ1PR11MB60831AB2202FF0C3CF99EF1DFCF49@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <b63056f9-0709-736b-ea5b-5e903410cb1d@huawei.com>
In-Reply-To: <b63056f9-0709-736b-ea5b-5e903410cb1d@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5816:EE_
x-ms-office365-filtering-correlation-id: dbc27527-9428-437e-9e32-08daf00d6ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sjPTNn2d+yZ0Ujrb0weefcSy2RwpUhYjUuj7/XFKWantJOXdEv+W+4bxEPyViKpY7lkTXXvf5K1efYTqZHCQGRLX7k51Xl1JxDErNLs8pWlFPFBclV3h0ZOuy5p08w0SEg3OiLmeWHQGYO/x6EIym4vEVbXWlp1yYItz0dOr/Bxa+eIhscrTzqG8y2Agkvd62SGh+AqP9C8IroAay3mox4RLmY8faQcCskK7RYTb1UgzC8PpBkZZQqsagbuj9v25HZ410Zy8dbsVWi1lSIJPT00PhfYNaxsdMdzCgNEZV0H0jagjwINjo2J3RmukRy40xgQq1+edMbgW9Rb0VsTS/h8UGgDQfOntvAQhrTO3nXKJ/RC+fqkmqEyvgzXDA0rp920M7VTCD5cBdZDTTqpygaqI8IpvVjFaTQb4/78N5p/DOuXuj+rpSdUO8b3o80H547KtU/D/lkuYtW0k963WQvf0DhBqGcRoWdZGV6SW2MY5FmLcbCdZo2CWPwUVUqyEBDO9EpERjxumC+ytBL/1VMsd4ZR3oiK39gdD1CuRXQO50bwtVEK6w4ofq7aANPdwGQee0ZpXcsWfa4HuII7CR88gJkw/CQk157Le8mhBHKwXiyC2vXC+pJgPxY3ErlQLRhRk5Gg7KO2xlMdccXDJ7XmTIUy/bPTRUK83c4kjie2BJQSNXhAbqXvbV0rBCWNs5CTLd/IJ7kHogZbqM+k/0+aNk2vY5ZITRmDHtKHWOMg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199015)(6506007)(478600001)(71200400001)(966005)(33656002)(86362001)(7696005)(55016003)(38100700002)(122000001)(38070700005)(82960400001)(9686003)(186003)(26005)(76116006)(4744005)(52536014)(5660300002)(4326008)(64756008)(66446008)(8676002)(66946007)(8936002)(66556008)(66476007)(316002)(54906003)(6916009)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eURKcHdrTG1ydWZGbWdYcUxjeVo5L0lhN1FNaFBPZTltT2JQb0cralprK2E1?=
 =?utf-8?B?VTc0TzJDSHFmaGtXTXpoazRvL3pkQnhTRnlFU3Q0SjhZYnZKMzZXSmhEcWtk?=
 =?utf-8?B?NVhXRHhHNFhiSTJIeHFvRHgvTzE2aExRalNBcWNsREtlNzVKUDlhM24rLzJX?=
 =?utf-8?B?UUFtanllTnU3TVRFMkt1M1dKZnFBdzJYMlB2WDdVTVhKeUhPMUZuUzYwZzd1?=
 =?utf-8?B?K1ZNdngyZTduMU95UG9QYnEwUU9yWTF4N0FRUVIyMm5iWDRjTnlmS2FXUmhP?=
 =?utf-8?B?QVFabGRjZzNxVzFzSzZwMlJaYTBvTkFNWVJSWHQ0STkwT29senNCOE15bkdC?=
 =?utf-8?B?WWlxRXhZZGRkTVNuRU1RK1J6QnFJbU4xem5TSCtVS29ZY2psSXRFdlJDQ0Q3?=
 =?utf-8?B?empibGtEeTBrUVE3L0xrbWJLK0NldkpDTjlGTDlKMUNKR2gxbG5yL2IrNUpH?=
 =?utf-8?B?cWRqS01hSG9EV2ZHL1lKWi9oVWhLRUxhUjFZdW1TdURtSmxWMnBrL0hRMEo5?=
 =?utf-8?B?cUxSV2dRS2tQSnkvZFYxUEpCcGd2VzMwc1FHZjRRSUloSGh3YmxZK2pPSS9H?=
 =?utf-8?B?bUZoRHdERnRMa0xMem82WGxwdmorcG1rcUxGR3hDc1NjMkxBOE5xS01ldTM1?=
 =?utf-8?B?MzVsOGUzYmRxWkU2SnlncS8zWFR6ZDVBTzNLSzIvSzJYVUVHNW9XRUZiNndT?=
 =?utf-8?B?dmtKbWVHWE54UUoxNXJ5Smw5ZTBxNXJRSksyZGVXMkNoMHYvYUZuZHRTdVhK?=
 =?utf-8?B?bHRReVFMMFpIWndDbkpVNVBJSWNlQVlUdkljNkVHRjVsbkVpQVd4Sld2Q0dw?=
 =?utf-8?B?UXd0ZlBUTnM3eGRLSGh5VmFiV1MyL2pPenRHU1BkRzdZL0tReWk4bEdlTVFR?=
 =?utf-8?B?N2xkTXo2eVozdFN5ZlZSSWFYREVGK2gwTU5CcGNVb0hmUk9VRndhR3hNM2ti?=
 =?utf-8?B?bUdLNStkZVlrRG5NWUV0SGwyaVdsOVZLTEk3SUpPdEJPdERZR1pwc1JZRm02?=
 =?utf-8?B?cUhJZ2o1MDhVVG9zRFRWcjlPRmlBOU9VaUcyNzczSWNVYmZ2Z3ZwcDFvWkhP?=
 =?utf-8?B?Vi9hNlhoOW9CT1lhNkU4ak9hRDVqQjVINGZBUkFocDdKL0xZb3Bub2IrT1lF?=
 =?utf-8?B?MnRoMkpZMFZlQlNmVDNiY0ozTHlTdExqUkNMZURJejFUYnVDeTNtdzNBVHRm?=
 =?utf-8?B?dmgzWHJoVmJRRjRuQlExaUc3MlcwNVE2cDVDMXNyWDVUd0tkV205NVN2aDhn?=
 =?utf-8?B?bHgyRkJmTUtrN2l0U2hVOEVRR2gyTDJrUGdpRTlheTZGZVNpYUIvNW5tYktF?=
 =?utf-8?B?VU9tZXN2dVJrSmVvaW16V1JxQm82cUhzbEpJQjF6cStzTyszZU9zNENCTHRB?=
 =?utf-8?B?Z1c0YTRKeXJIZjVDbmdFV0ZLSVB5NXl3Y1VwTy9pZU4zZ2haVENtaTVZWHpS?=
 =?utf-8?B?ODVETENzTXJva3VRT1pWSEFvaVFPV0llUlBUaXY5akN2YmRERkhmZ2N3ODZP?=
 =?utf-8?B?MkwzTmpCU1F1RnBONThtMGc3L3FDM0VxVTkzc3JGeXRWajhtcUJYbncwZzJR?=
 =?utf-8?B?M2Q4bDZXZGhhZUsxQzJXYUQxS1FUekZoY1V2bDFMczM2SUtlSzdSSHFVMklt?=
 =?utf-8?B?RGswUzFuK0RtL1VicDRQRkRaT2ZGcUZRanFlQUtSb3V4RjZPdDJSTGJrSFV4?=
 =?utf-8?B?Y0FyeUxURTVTKy91Zi9qKzlyUVg5dmVENFZFZk9JR0EwbnUxZ3hPakxUaXpS?=
 =?utf-8?B?S0NYeGN0UUppL1ExUkdhQ2c1VWZhKzhHNU9OenZKSlBXL0g1NkE2bnM2YTVT?=
 =?utf-8?B?Q3llSDVRRjh1QkUxL2VQMnkyRzNsUURYendYSk1QcU9SRTZtanpIR3N5aWtV?=
 =?utf-8?B?YVdNcmtYZmFuQyt6ZjNVWWMvNlVCdmJubHM1UHpqUS9zTWZZRlJDTUZzeXc0?=
 =?utf-8?B?TS95dlBBbUlmcmFEblJMU0ZwVWxrc1hENWhtRzFIT2NJdVQ2LzRuN0kvbDNX?=
 =?utf-8?B?QkRqRUdOd0lzUnB3Q2NYY20rN3dtUVd1UjFOR3lDM2dHVkMzNlF0T0FxdGR6?=
 =?utf-8?B?U1liM2p3VE1QTHpISlhrVmJXVlhBcnBCaUVRbEFKOHk2YmhKNGl6M2YxeVht?=
 =?utf-8?Q?t/5LWoE+qNHNrSLTBQ+43roQW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc27527-9428-437e-9e32-08daf00d6ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 17:42:47.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2gnuPp5jU1sVDv1iTWGNtXN1ZqgnOVxDvUyNdTl3YmLu+44Fb0UyW7eb10WjACUAs9WqPeS1s4loEIE47h/UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBBZ3JlZS4gQSBzdGFjayBkdW1wIHdvbid0IGJlIGhlbHBmdWwgaW4gdGhpcyBjYXNlLiBCdXQg
SSB0ZW5kIHRvIGtlZXAgdGhlIHN0YWNrIGR1bXAgaW4gY2FzZQ0KPiBpdCB3b3VsZCBiZSBoZWxw
ZnVsIGFuZCBhbHNvIG1ha2UgbWNlX3BhbmljKCkgZHVtcHMgdGhlIHN0YWNrIGFzIGV4cGVjdGVk
LiBXaGF0IGRvIHlvdSB0aGluaz8NCg0KTXkgIzEgcHJlZmVyZW5jZSBpcyB0byBqdXN0IGdldCBz
dGFjayBkdW1wcyBmcm9tIG1hY2hpbmUgY2hlY2tzIHdoZXJlIHRoZSBjYXVzZSBpcyBrbm93bg0K
dG8gYmUgcG9pc29uIGNvbnN1bXB0aW9uIGJ5IHRoZSBrZXJuZWwuDQoNClBhdGNoZXMgdG8gZG8g
dGhpcyB3ZXJlIHBvc3RlZCBpbiBTZXB0ZW1iZXIgMjAyMg0KDQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyMjA5MjIxOTUxMzYuNTQ1NzUtMS10b255Lmx1Y2tAaW50ZWwuY29tLw0KDQpC
b3JpcyBoYXMgYXBwbGllZCBwYXJ0IDEgKHdoaWNoIHdhcyBhIGNsZWFudXApLiBCdXQgZGlzY3Vz
c2lvbiBvbiBwYXJ0IDINCmNlbnRlcmVkIGFyb3VuZCB3aHkgbWNlX3BhbmljKCkgd2Fzbid0IGdp
dmluZyBhIGZ1bGwgT09QcyBkdW1wLiBUaGF0J3MNCm5vdyB1bmRlcnN0b29kLg0KDQoNCklmIEkg
Y2FuJ3QgZ2V0IG15IGZpcnN0IHByZWZlcmVuY2UgLi4uIHRoZW4gYSBzdGFjayBkdW1wIGZvciBl
dmVyeSBtYWNoaW5lIGNoZWNrDQppcyBiZXR0ZXIgdGhhbiBubyBzdGFjayBkdW1wcyBhdCBhbGwu
IFNvIGEgcGF0Y2ggdGhhdCBlbmFibGVzIHRoZSBPT1BzIGR1bXANCndvdWxkIGJlIGEgZ29vZCBz
ZWNvbmQgY2hvaWNlLg0KDQpJIGRvbid0IHdhbnQgdG8gc3RpY2sgd2l0aCB0aGUgY3VycmVudCBi
ZWhhdmlvciBvZiBubyBzdGFjayBkdW1wcy4NCg0KLVRvbnkNCg==
