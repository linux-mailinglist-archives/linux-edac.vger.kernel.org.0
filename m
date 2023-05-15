Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FE0703769
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243989AbjEORVB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243961AbjEORUp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 13:20:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962F124AE
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684171111; x=1715707111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hwhsTfXbfeuzs96PpgyxX2t1Tozs0DG3gW4LW0t1fs0=;
  b=D55qZn64fJswwamHJGuf7KZ8lRXV0a1g2lL/fqGLn0k+PgClRBJhdQMH
   nJiy/E1b8rQBWsLwDKVwqL5sppSzo+cPQR0Q8LjRGpOwpSZA9aLX/CqYz
   1ZXSH9hsQi1g3BjE+MMmurCN4XPMVBII2f36+wAe2O+FnArBOtNZjwX6r
   0lguIfeB/cmCtJSWdO+9GbLqZJ4344lv37Zbici4AJzgN+aAtASliu5pX
   yCalP7w+Mp5oANm+hCQtpIaF/ZYWQZ38Nda7Y0aupBMNaT8Snv3qcyu1M
   Bm58l83N9GUlghdfMwHIMVirGJSb9N66ODtNUDr41GmJERhAH2feRtyEk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="353535150"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="353535150"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 10:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="770683434"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="770683434"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 15 May 2023 10:18:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 10:18:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 10:18:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 10:18:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 10:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqWTdEbYaiGkaKDDXn2HJkrybkjm/Oa7nbvGcVZb+F4XtS386PC93eJoaNffIF26nk7t54w05/2cZoR3Vtro1hRx+cC7jP+oVpvZTEcn60JmKYcRYFgD3ITpiXkZ/C9ivzeS3XYsOY9v/NjXWkJF60HRdj5G+qr5dX6zmKrGNy7xvW5ytidFKmT4aCknbMmhYTuTDmeUWEx0EZMqBcGfYruHwyW+fglCLTNM9tWoWUWm2dPZu1AIWdJxPlIBxGbywybAiTt+9zw2X4mVz5L/tBVztDcO4wqPdvbWyZn9OC64AcTV5fasn99LbOMumEy5OJiaTvei7yrHq+a0DUr/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwhsTfXbfeuzs96PpgyxX2t1Tozs0DG3gW4LW0t1fs0=;
 b=O9GO7mYcJP6JTdmwmXTt5KQIPKcuR094fS2HJFCTX3emjb4KlbxiPHqX/+O66fuJ+C434EVP42BZHuPCL6VoBA3pP0OTldKMU16pBTYM2XmlaK1owISDRj+kdJj9SIskI45EjC+xAQ0ELJURp3dahEBg7x9uxz63KDgK4guKR6OfWvaITqconLKvMsYI6OU9i4xXyFoU/ZILNCAknrXJVuuwZsj7EKAOyn9/+9FWElJ/HNeD/syisSBmx41OmqKgSiJqlC8PbxmDYT6MXb4MJVOnqOXlMdT5G9k0nTtm0ologQoCrrG9vxYRS5lCAtpfcJyIuv70P6Cj6L7J55uEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB5659.namprd11.prod.outlook.com (2603:10b6:510:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:18:06 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Mon, 15 May 2023
 17:18:06 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@ruivo.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Aristeu Rozanski" <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7A=
Date:   Mon, 15 May 2023 17:18:06 +0000
Message-ID: <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
In-Reply-To: <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB5659:EE_
x-ms-office365-filtering-correlation-id: c1c850ed-1312-4cfd-b540-08db556858f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cx+mVY0bJTTKJTllwxtv4pfP2g3miRaSJNeiw0SoaN7/b5/LMYBpDd0/5YTd57MSWWQv+eHIJuPeMu7FnOH7OVnc3x5f+WyqdYWJWDgULi5M2QKCBH/xuvtolRaZ1bjqmVlOAHzsNhA1S1p4EHkzi8bgJwbk+mirHgwNEhXM4xSbS6eEdFxYZiwDixcau2m3PkvTallji6jvuZ/tTGCMag52tyQ44PdGrrYaijrhCJY6G5Q8AHynpciEQ4j9JH8PvhARb8df5HckWwzXzjkloNfxYj8zGrb2sbv5HX4QrU+sxEorWsDol/trk5+8MY8j4xDDisgb9fnlZvz2nuRkEyq7DZQlIdiWmf0HudlIdmLOzyjmkeoaa/FMxWNR7NQWhj6mSudnVgRyFokR8k/kckuA/EjIan+06GMmwiT2IortEFcU5lKIoFw3nmkE9gC0LA7WSFYB47IBfMc/6likpDDzNQmhOXnHONk3LreJ+1GzZ7La5tLso+InlAduL5Rb6qp7vA/RTmb0gXOOeAY9c7LMMXAs8SZXX0RHajs1mhl/vHi5OI16kdYBgdjZyXtE5NbUZMP4Y7r12OJZPURu9/K41i03qrCrr68g78UOf+uF6zT8LX0MpoTOjt6bfprI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(54906003)(478600001)(86362001)(83380400001)(26005)(6506007)(71200400001)(186003)(33656002)(9686003)(82960400001)(38100700002)(122000001)(38070700005)(55016003)(7696005)(110136005)(2906002)(4744005)(66946007)(66476007)(66556008)(76116006)(5660300002)(64756008)(66446008)(4326008)(316002)(52536014)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXpDcXpiWkMxK3hodE5tOTNUZDFUK3FoWjZCa2tFdStFNVQxeGJiUDUyMTFq?=
 =?utf-8?B?L0MwSDJMdWs3cmFVempHcnNUMG5hMmhtTkV4ZFZZeGR3NlQvWkcxaEsxdlpL?=
 =?utf-8?B?OHhzRk5YRGwwSWptb2tHbVhYZDdFWGdJK2RMZUpaanpjMmwyRDFZdVUwRG1x?=
 =?utf-8?B?b2F5Z09YTCtTbVBoRWFldk1RN2tzYUU0T0h5OEdSbGpMcFhBMS94Rks0Lzll?=
 =?utf-8?B?cEczQkxFOWNoZldRb1FzWUhjaldRTUl0L2NNNW1YSFdWb1lveWpBWFdoU1RK?=
 =?utf-8?B?d0paUnNMcFNuT09vS2JjeFdBb3hCYWJUVnpFUVU3RHk4dWwyRkFoYTZZcUM2?=
 =?utf-8?B?NDZtdjRkczlvc1dJaDlVeFpHblNJSWMvMDFpZm56RnFjeVlXNEtDMVVmbWlu?=
 =?utf-8?B?bkNpbEJQMXhtbXYyMk5pd1RnYjJrenA2NXBwTHV6OVlWMUNweHpOb2w0ZzBF?=
 =?utf-8?B?aWpZVlYwYnZMK21WYTA4VGxJZGNIc3JMTHhua2lzTFZST216M0V4b0FreThX?=
 =?utf-8?B?ajdrc2dkMmluZ1ZGbnVaNW96SmRmUzQ3REpqenIyK0lzY25LdndBMjI2NGQr?=
 =?utf-8?B?ZFhSYy9aeEZLcDFSbWVlOEttb1o1eDV3dDFtRGxZQnJSUzl4bXl2RG1VYkpz?=
 =?utf-8?B?a0QrQmt6UkRaaFR3Unc3Ni95ZXIvZUJXR1BhMCtqQnE1TnV5aVpwZ0Nnemdz?=
 =?utf-8?B?OHdSNlRDdzk3WHlCNTcxYWhuZTFSNVFGTDdNSGIzWXV2akZNSnpseDRrSVdC?=
 =?utf-8?B?T3dIRXVzd2JpNnhzUnNiSjRYMmhGcThjT25lTm5ETjRNbnVieEg2dUdpMmhr?=
 =?utf-8?B?NzJBNW1BU1VROXVkZXdKTk9oM3JUTUNaZEduQndRZHIwVWVybnQ5SXhCMHNm?=
 =?utf-8?B?L1IyVGJvMEVwRVJUWE96NFdqUXIzdGhhS3ZwbGI0MS9UV2pJamxVbHRTK1Fa?=
 =?utf-8?B?dVQ3MGhkV0UwYUN2cnNWajVFVUo5OUNWMkdPTitydkNtMW9FcFpjTlpWNmlj?=
 =?utf-8?B?NHYwV0RKNTdHSXdtcTU5bTc3MENDNUdFYllGa3hrWDVMMXljdXFZZEVPWmZN?=
 =?utf-8?B?RjhYVkJ2SmVHbnZUQTlJSXdQdDQzU1plTXNOQ0xwNjVzVEMzSytZbGpHdU5Z?=
 =?utf-8?B?TDFmcU00TEVPU3laVVhtc2gybjJram92bFp3SEo2bDJYZVoxWW5mTFBleDFN?=
 =?utf-8?B?NFBYYTNHZmM0M2ZiNUFjaXdLRGo5VE5odW1KZHlMZW1qQkE3UzBDRFg0WTNE?=
 =?utf-8?B?WXBLSXd1WitOcVc4T25IZzE1c0szeHhKeG1hVkJPeHRTSnB1WG9PYm5wVnV2?=
 =?utf-8?B?NnBPZktkWnVraUN0SVgwTlhVdEtHZ2ZnN2UxZ2d3a2tXcVFNUmFJRDczOStp?=
 =?utf-8?B?Ym1CUXpZWjdWb2dzdy9GdUpMTUl4RkhMbmM1MkduR3Vqb2dhcFowVGVVdHhh?=
 =?utf-8?B?d3hMZlBLT002VWhReHphTnRrbFVncm9PVllrZEV2eDRodmNDMVZEMVpDeUJi?=
 =?utf-8?B?bDhhRnVwbFIwdFM4L3VUazNlbTZTakhLNDNndzl0S3lsRVoyd29ZYVRhaEpp?=
 =?utf-8?B?eEQxRjdBb2VJZlA1VzYzelYxVllMVnk2YlFXVkNYM0dxaW5WZ3B5MXNZcENj?=
 =?utf-8?B?bUxqRFloNlA2VUdnZytWdlhQNy9aSGZqQi9YaW53RFlpOUpHQ2gyN3ovYlVP?=
 =?utf-8?B?RVQvekMweHNLTEs0L05FNUlsRVpzYis1ditXNEl2TnZURGpsSElWb25uY2E0?=
 =?utf-8?B?b1dWQzBxck1mNjB0eHhsT3pNN3Z6T1RjWFF2L2tndkRUdHBXbmU0TnlibUdj?=
 =?utf-8?B?Zm5IZEN0UTJjZDMwRUl2RDQ2WFNpRElVTk1lTDRLTVd0R21pZnVoRklRVXlJ?=
 =?utf-8?B?MWltOGZKMm9BS0E3aW95RUxOMTV6RnluT0JCWDg3dmFRS2d4Y09ITTJDY0dX?=
 =?utf-8?B?ZWlxTzJrTC9TbUZ0MnllbThLLzU2UlY1WTdhbk5xOGxsT09UQ2dvQUpUQnBC?=
 =?utf-8?B?c0JQb2Qzc2xvbXdBMTViaTlabXg2U09aaXNLTFZseVhGdUVVejFqQWtxaW1S?=
 =?utf-8?B?U1ZsbXBwNElKSzdRb3dxMGlITXlhMnFHMGhnRjJHTllvSUFaNDVJQTVKR2hF?=
 =?utf-8?Q?fe+I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c850ed-1312-4cfd-b540-08db556858f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 17:18:06.0427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zggr94/kgE1Ey4kpP0VNKPlS/LtxGvufqHgPyCSgNUZnfSeAN2rG6gmvg+MTF/K6kW166dwdY4StUy5WfBB1FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5659
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

PiBTbyB0aGUgTUNFIGNvZGUgYWxyZWFkeSBoYXMgc29tZSBub3Rpb24gb2Ygc2hhcmVkIGJhbmtz
IGFuZCB0cmllcyB0byBwYXkNCj4gYXR0ZW50aW9uIHRvIGl0Lg0KDQpUaGUgTUNFIGNvZGUgb25s
eSBrbm93cyBzaGFyaW5nIHNjb3BlIGlmIENNQ0kgaXMgZW5hYmxlZC4gVGhlIGFsZ29yaXRobSB0
bw0KZGV0ZXJtaW5lIG93bmVyc2hpcCBvZiBhIHNoYXJlZCBiYW5rIGlzICJmaXJzdCB0byBmaW5k
IHRoZSBiYW5rIGlzIHRoZSBvd25lciINCmFzIGRldGVybWluZWQgYnkgc3VjY2Vzc2Z1bCBzZXR0
aW5nIG9mIGJpdCAzMCBpbiBJQTMyX01DaV9DVEwyLiBUaGVyZQ0KaXNuJ3QgYW55IG90aGVyIHBy
YWN0aWNhbCB3YXkgdG8gZGV0ZXJtaW5lIHNjb3BlIG9mIGJhbmsgc2hhcmluZy4NCg0KSW4gQXJp
c3RldSdzIGNhc2Ugd2l0aCB0aGUgSFAgc3lzdGVtcyBDTUNJIGlzIGRpc2FibGVkLiBJIHNhdyB0
aGUgc2FtZQ0Kb24gYSBzeXN0ZW0gaGVyZSB3aGVuIGJvb3RlZCB3aXRoICJtY2U9bm9fY21jaSIu
IFR3ZWx2ZSBDUFVzIChvdXQNCm9mIDE0NCkgd2VyZSBwb2xsaW5nIG9uIHRoZSBzYW1lIGppZmZ5
IGFuZCByZXBvcnRlZCB0aGUgc2FtZSBlcnJvci4NCg0KLVRvbnkNCg0K
