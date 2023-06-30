Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629E4743737
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jun 2023 10:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjF3Iba (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Jun 2023 04:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjF3IbX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Jun 2023 04:31:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A61FD8;
        Fri, 30 Jun 2023 01:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688113880; x=1719649880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tE5c7W4pPKHHv3wj2pxnhvOL2DNWeD3nukOHWcG7QVE=;
  b=CEmLWNqHPyVVyOTD+9wMeRpMA4FA/pxFc+62ge6U2Qezp5UjCU2XUtlD
   T5eCKFayY0nrGT2SRooMYhNVGsq3P7uPuQmMSciXWnRnw2c3gKwuWhH03
   H2RJ1a1zgRT8Y5JMCIwLi0WNrFZNdNfgstl/9wewwzhAAKBMfvFWo7T9k
   VwQQ8qAIVy5xt4vzK+ynTpWlKW+J72dyhvZmZfQw+pNpqYDYlCUW/RdVb
   t/u0rXKU0Q+HJhKYS6Cxegs5/lqjGklLjNIW5SdByIVAfWCiQZd+AMWm/
   JLiZTVq1UdalqHPDC0wxNKg+sxFgwYdtJskCKnTraqNB8S3f3J6UtFLCO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365831452"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="365831452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 01:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="747342837"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="747342837"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2023 01:31:19 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 01:31:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 01:31:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 01:31:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUFQcuXDBSa+CItsu7PXmJ8KV7v37+gVZ7xAX+8PT54n7hEVedZMzY77zZGOuFt6E5gf0LcZOyyzYwtmBzdzA8JBGf/6ZhzAaS4ZQHGiyYpZ48+onV5HzXlLtgFSVNa+/3gvHnivpGDNoWyyO7ik8SN+65M/EDu8YWN2cp6r0OF9GVu9EkB9LmOqf6nIQBgixmdtik639f/NQGYSLmLHjQI+1dRfgwWO4urUWM7OzUVuF2UxaYl5/176E/tWz6FMIj8X8XB+KLMlpYp6QiFRKKGh2rJvWpuDUNUiMm+QjS91N7sW5YNxLLgLnKgHb9VAgpI2WYmmJ9in6cGAOhGn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE5c7W4pPKHHv3wj2pxnhvOL2DNWeD3nukOHWcG7QVE=;
 b=B8pU7ONOugYlW1erqQNLNnqtxqLiZO0FhJ8kTNbfq7UBLqS8GOg38CLXFDE4u2Et+IOykG+WFJEFnpUqxaSjWs2MPVcTlX/l+d16zWx0qya4wKWmcWzrJrDXzouovEkLb/P+BZnklNrYQX5zd9AVlFaN5C8RSUnpS3g+bJAuSz5h4bSnxfQESgBdFY+dmFiCMQeQDBwW7WKwMi1Z0iIpvbEsyaq6bQao7tWZLmmWNJ+7OwkWTdN8GOf+bdZcb9SREyjV8I+tCHngMiVzb6fYUFcA4Gfim/lkbGLvABS0Q9qKkO9jwT4f82LoxTvQMSqVitjtNvmmZ5XfP/cdqLj97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7130.namprd11.prod.outlook.com (2603:10b6:806:29f::10)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 08:31:15 +0000
Received: from SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::6123:b5a4:9e83:c963]) by SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::6123:b5a4:9e83:c963%7]) with mapi id 15.20.6521.023; Fri, 30 Jun 2023
 08:31:14 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>, Koba Ko <koba.ko@canonical.com>
CC:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/i10nm: shift exponent is negative
Thread-Topic: [PATCH] EDAC/i10nm: shift exponent is negative
Thread-Index: AQHZqaGVpIqT6jxceUae4/C3IJvH+a+gawgAgAC7+YCAAFsz4IAAc2QAgAERSdA=
Date:   Fri, 30 Jun 2023 08:31:14 +0000
Message-ID: <SA1PR11MB71305B71CCCC3D9305835202892AA@SA1PR11MB7130.namprd11.prod.outlook.com>
References: <20230628085253.1013799-1-koba.ko@canonical.com>
 <SJ1PR11MB608340E81A15F20EBAD75F08FC24A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+U7Af3ypru3O0quGTqrsJPMO3b7uoBTNjTLSixrmrvXJw@mail.gmail.com>
 <CY8PR11MB713480F6D06D11BC4742AA0E8925A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB60838660FB93BD26F4C824A5FC25A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60838660FB93BD26F4C824A5FC25A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: koba.ko@canonical.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7130:EE_|CO1PR11MB5121:EE_
x-ms-office365-filtering-correlation-id: 2ae50cf0-4dc3-4a7e-eee8-08db79445e02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ha9tle9rrn2mPJzccyr2GYmxWdcPG+QDz+B2KvXZFnDOza/Rp0QmJL79GTUAPISLBx4B7XgHR5fNvGzo70LM5Djq5mhdfHLdXqmPyXZRuHWAv9HeDPiv4pjOTrw7AlH2icAom+p2fXXi6U79jFTpd0M4HlWDWls3gTWTIMJrUWIVJfXRlt1bcpZ9g91PEyuq3hTLmj03tEqDuIGJKpda2QS46uMIPQ3th7Fse090Q8nZEc9XsNNn+JucHWHRWDV0Q0R5Ynav5lnNHOisgUY7LKlDSX+VlLG+1uL/NE3Clo5iNjXlVE7lzqVn7YS0sfysGqcKLR6LkxIEFgHVxanPA/opoXrs/NoQ3FFmJ4ZfeeGBQJ0+JZXycZa5328pfDu0Dx5UmNyV+xV24N7mulY/TvEmJDEdAOzHxsda/n2dPne5tx6+CkGGi9BHZU4FczdqSCq3/WL35MktbugmKsYbkzxv204nOR26hQXthjOtXImq5P03KeBjNh5qfWb5n0syLPMFoBusSFzkirUNSOVDLVtComL959LBGvSjkS+ibWlNtxbKr2KcqV1/3yaskYMb24+OFsVZpnckjlGTRxLzkBN2D+YyatZq4cGpLev6HZV9mEPEKJeccK5jqKb0eRhA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7130.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(83380400001)(38070700005)(2906002)(122000001)(38100700002)(82960400001)(55016003)(8936002)(8676002)(110136005)(5660300002)(52536014)(86362001)(71200400001)(54906003)(41300700001)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(316002)(7696005)(33656002)(478600001)(186003)(53546011)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UThXaUlHcEhyYVFKSEZKbXlYMW9ibWtZQWlwa0ppTzhQc3lHdUxhUVhBNzk5?=
 =?utf-8?B?YVRMcmdjUENmaUgxTjF0cjNaa0xnSHdnbVRiUnBNOTFPWitJVE1oc1FqMHR0?=
 =?utf-8?B?V1YrTksxSjRtOW1oZHozQU5OWTAyZW0yMDhKcDJtd0ZZVG1qYWVDbFNNZkNP?=
 =?utf-8?B?TDNJa2NBS3VKTEtOdG5KamlHVmI5WXl1UXlDMVU2QkF1ZzNkdHQvU0d6SzNY?=
 =?utf-8?B?cVZ3V0xYdldyYjgzQmVvRzRpM2ovMEZRSDRvNEVnRENYS0dTZWVPcksraml0?=
 =?utf-8?B?aXBYd29XS0ZFdEppdjM1dUlET0tOb2dVZVBSdEtTRVRvTUxMc212YTh2ZWJ6?=
 =?utf-8?B?Sk1oK2Njb0tTbXEzZWlDbTVwOUptZWhxZlpMR3AwR3hoVjBOS3pGZmpuQUZr?=
 =?utf-8?B?MGxTVjVvajdjUnpZMmFZbWdtejRmdmFFekx2M2xRRFkvVHJiTU5ZS1lCNnRy?=
 =?utf-8?B?OXJjcmpKdm9MVWp6aXVjQTJtZUtGTWE5NjlqbmNXbCs0L3U4OUdiTVBReUpZ?=
 =?utf-8?B?dy9GU3V6ek1jN21sV0ZEUXlwMkJTSjV5NHduNnQzZ0REVGZENlpTQy9IMWtZ?=
 =?utf-8?B?V2xyTklsQWsxRVNNKzh1UGxhYWdtTjZDcE4rdUJ2cWNTVlYrajUvUVFsYkYx?=
 =?utf-8?B?RU1ZTmNBV1VoM2Y0SkE5WjBVRHBqenRxSmNMM2tKc0c1YmhJWktuQmcxOHBw?=
 =?utf-8?B?elNLajZuMTFEQ21xNDhwS2dQSjFkQmh0bjRlWFZya1N1VUZRY0tpWFVxUVVu?=
 =?utf-8?B?WS9QdUhRN3VpdzFQUGQ2YnlCdTF3Zy90MDd3Vno3STYvaTdpcnA2cnR3T0RX?=
 =?utf-8?B?cFdQWWN3SkE3Y2xFWWlqK0lYM1hhVnpuZTNMSHo5T1NHbnYzdXhkS0lVdzNu?=
 =?utf-8?B?UGFKTVV4UURjNytWeDQrMkRpUXlzR0hxdDVzSzF4MDgzRkhXSElKbjQwcHNI?=
 =?utf-8?B?U3QzdE1LUTlyOEZrclVnTC9KV0c2N3p2UWc2aVFVWUdQZk42Y2R2dGd1QzY3?=
 =?utf-8?B?STlJN0IrdlZ6RSt5VFYwSnZjb0czbEJGeVcxWkpJdzk3TkVSWlFtbi9HT1pH?=
 =?utf-8?B?M0tSVk9jL2hQVDFHeWdoc3E1YzJ3MnozK1k2T29JUW03SjVmWEdVbjJ2SXpo?=
 =?utf-8?B?NFR1WFBGUnVnVWg1WURSOTl5UDNENHZqdVBoMWRLcVdmNmRZcnd5c0VhSWNm?=
 =?utf-8?B?cEo0Y202dDJvaCswNEZ1N0JUSmtNa1YrcDQ3YjM3WkVrVGdqc3BrbWU1Zk1Y?=
 =?utf-8?B?MExtQUJHU2J4VnhVTTF3Zmk1R2lkL0l0QXlwTll1bGp6T3JIcTVveHdHSFRD?=
 =?utf-8?B?OWx1amJtWUpncllTODZCRTdIOXlDUFVIaWIyZ0dQY1dLbnp1UjZVd2RaT2Iz?=
 =?utf-8?B?MkE1bkVQYlpiRDRhUUpGSytXWnp3K0dUTElNMWFTNG9WbjBEOTRQa1EvZ0ZW?=
 =?utf-8?B?US9lVWNOd3pyYWJyNitrZHRWbkpKU0NaUTBIRmwzR09VT3lOK3NGQXA5QlNS?=
 =?utf-8?B?ZTBIOUdMcUlhMVpFMkFQL0w3S1YvbkNTZEtBYlN0V2hXMW5hSnZ3TUtpUWs1?=
 =?utf-8?B?UjNRWkJlUzhjcjdjMCtnQzJDVDBqWkJUbXlWRnQxNndEajVnRGpOaUYxV2Zi?=
 =?utf-8?B?SkdTdDhBSjNHMHFyZFFWeWkzTnEzcVVQaFc1dmU4dUdzZGhxeWRZcXEyOVJ1?=
 =?utf-8?B?MjRuUHdTNFZTZGt6aUp0NVNnNExEcDhib1J5VUxwWnB0aWJLREsrOFFaMkd5?=
 =?utf-8?B?OHVCU2hTWk91Z1lnQ1FlTUV4bFhlR3V2VE1yV0xXMXVCWDlNVXBtU1dHS01i?=
 =?utf-8?B?TTRiczNvMXZGYXZjTmMzbDRMUmZXQnJzQjZkcU13V1JhalhZSXhJcWNJUm9M?=
 =?utf-8?B?Ykk2REpMV012ZXNSNWpvYmpRRzlzK0dzK0o4REg2Q2JDSXhLQ0hyekpEaUNV?=
 =?utf-8?B?RjQ5QTZKWGNwTEpUVUNVajJOMDF0b1lyU042QWd5SEdYZFVHc0twZ1lHWTht?=
 =?utf-8?B?NWxIa0JTdlk3ZnJwQUpIaDN4UXZ5bFlBeWRZRXM3Y1JkZC8xQTkzemJXd1VL?=
 =?utf-8?B?ODZvYWtuMVU4bDJwUGRScFFiZDY2bDlVSVlVQlRENVhodkx3VGxJTGtIU2ll?=
 =?utf-8?Q?V3MOjq2v/UatoqT5QukymMndt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7130.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae50cf0-4dc3-4a7e-eee8-08db79445e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 08:31:14.3053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/xhvdZgL7nD2kN3U36E09IE5ZU0AQMDl3uFofYS7WJ8uPlF9k4L6hNBpVUzl/oOIejG5m17l7CEzPNRNYK6tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBGcm9tOiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXks
IEp1bmUgMzAsIDIwMjMgMTI6MTIgQU0NCj4gVG86IFpodW8sIFFpdXh1IDxxaXV4dS56aHVvQGlu
dGVsLmNvbT47IEtvYmEgS28gPGtvYmEua29AY2Fub25pY2FsLmNvbT4NCj4gQ2M6IEJvcmlzbGF2
IFBldGtvdiA8YnBAYWxpZW44LmRlPjsgSmFtZXMgTW9yc2UgPGphbWVzLm1vcnNlQGFybS5jb20+
Ow0KPiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IFJvYmVydCBS
aWNodGVyDQo+IDxycmljQGtlcm5lbC5vcmc+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBFREFD
L2kxMG5tOiBzaGlmdCBleHBvbmVudCBpcyBuZWdhdGl2ZQ0KPiANCj4gPiBJIGRvbid0IGFncmVl
IHdpdGggc2ltcGx5IHNraXBwaW5nIG92ZXIgYSBESU1NIGV2ZW4gRURBQyBkb2Vzbid0IGV4cGVj
dA0KPiB0byBzZWUgaXQuDQo+ID4gQXMgdGhlIEVEQUMgZHJpdmVyIGNhbiBzdGlsbCByZXBvcnQg
ZXJyb3JzIGZvciB0aGlzIERJTU0gb25jZSB0aGVyZSBhcmUNCj4gZXJyb3JzIHRoYXQgb2NjdXIg
aW4gdGhpcyBESU1NLg0KPiA+DQo+ID4gQXMgcGVyIFRvbnkncyBzdWdnZXN0aW9uLCBjb3VsZCB5
b3UgdGVzdCB5b3VyIGtlcm5lbCB3aXRoDQo+IENPTkZJR19FREFDX0RFQlVHPXkgYW5kIHNlZSB0
aGUgcmVzdWx0Pw0KPiA+DQo+ID4gQEx1Y2ssIFRvbnksIFBlcmhhcHMgd2UgbWF5IHR1cm4gdGhl
IGRlYnVnIHByaW50DQo+ID4NCj4gPiAgICAgICAgZWRhY19kYmcoMiwgImJhZCAlcyA9ICVkIChy
YXc9MHgleClcbiIsIG5hbWUsIHZhbCwgcmVnKTsNCj4gPg0KPiA+IHRvIGFuIGVycm9yLXByaW50
IGV4cGxpY2l0bHkNCj4gPg0KPiA+ICAgICAgc2t4X3ByaW50ayhLRVJOX0VSUiwgImJhZCAlcyA9
ICVkIChyYXc9MHgleClcbiIsIG5hbWUsIHZhbCwgcmVnKTsNCj4gPg0KPiA+IExldCB0aGUgdXNl
ciBoYXZlIHRoZSBjaGFuY2UgdG8gbm90aWNlIHRoZXJlIGlzIGEgRElNTSB0aGF0IEVEQUMgZG9l
c24ndA0KPiBleHBlY3QgdG8gc2VlLg0KPiANCj4gV2UgbmVlZCBib3RoLiBDaGFuZ2luZyB0aGF0
IGRlYnVnIG1lc3NhZ2UgdG8gYSByZWFsIGVycm9yIG1lc3NhZ2Ugd2lsbCBsZXQNCj4gdGhlIHVz
ZXIga25vdyB0aGF0IEVEQUMgZG9lc24ndCByZWNvZ25pemUgdGhpcyBESU1NIChhbmQgd2lsbCBw
cm92aWRlIHRoZQ0KPiBpbmZvcm1hdGlvbiBmb3IgeW91IG9yIG1lIHRvIGZpeCB0aGUgZHJpdmVy
KS4NCj4gDQo+IEJ1dCB3ZSBhbHNvIG5lZWQgS28ncyBmaXggLSBiZWNhdXNlIGl0IG1ha2VzIG5v
IHNlbnNlIHRvIGp1c3QgdXNlIHRoYXQNCj4gbmVnYXRpdmUgc2hpZnQgYW5kIHByZXRlbmQgdGhh
dCBFREFDIGtub3dzIGhvdyB0byBoYW5kbGUgdGhpcyBESU1NLg0KPiANCg0KT0suDQpAS29iYSBL
bywgY291bGQgeW91IG1ha2UgYSBuZXcgcGF0Y2ggd2l0aCBUb255J3Mgc3VnZ2VzdGlvbj8gVGhh
bmtzIQ0KDQotUWl1eHUNCg0K
