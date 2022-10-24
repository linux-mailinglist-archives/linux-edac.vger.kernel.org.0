Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEA860BDC4
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 00:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiJXWsn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Oct 2022 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiJXWsZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Oct 2022 18:48:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423DF12FF84;
        Mon, 24 Oct 2022 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666645820; x=1698181820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8qpnNR4gd1MT+36gDSnwdaPtpx2ujFZcyLtS8jC+64I=;
  b=afOXUjHqcRhlnEA6/drZ9Ad2N/GyLfpeC0WvPXSYZSKCDhINNIqR4vB0
   aTzJbZ5ZBiXKJOWJ+VcWGp/W0YAAuqrGbqE1O70w4c75msP6CaG5skq6Q
   OobGsk3LyJrbCvKBw8UpZJyEflGc8xZBNq8T+5OXZR0gMVlU/uo5r6mHl
   DFG8OjgMbKAjB6JFXMDUtr6SIz6o+en47CQ5nXiznh2zCwPZg4zjAZC/n
   aaLlXISP79iiwcP0F89mQYx0cUWLuSaSJvwhyr5fQnqjtW7CKhjdN/cOE
   hvwFewwj0PCimeLRrCJyZBQ7BwfmGSiWPGxQhDG8oTcApz8pXwV8JFeU8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="334114236"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="334114236"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="960567509"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="960567509"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2022 14:08:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:08:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:08:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 14:08:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 14:08:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Csl8uJX6+GxkP+x4aA9qovzdiD9fHXOjLLge/e4kO5FyAmKrcu08P3kKW4Rl7yU0bhIOsseJizbWoAG6nMRIDvpa76NCDlMwM5bTyXzqRYwia1WGx71EKG4A1Q58ZvqC04PvjIQq2uFNyCT0ypDsb/ER5v9m4med3SgZzqrwQuME+8APzt0Gm2FkvsvouzSCcl5RiCOP/OYnZzF/qxdbz50JJGEYnb8pjd7r1AaJHB37gKykVSMAvhP/bgh986zYSuRW5WGu/Blb9xWvAWtwMTjYDptpgd/ep4pIoLgl9bFCsOCQNRYmrzFi6ZXFwCyjPchkhJWMhE+dKZRkXRHmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qpnNR4gd1MT+36gDSnwdaPtpx2ujFZcyLtS8jC+64I=;
 b=FSEnjXVTXSbnDHEpkqAwrAgPhCjMLPIeZ3Xmh8Us3Gxnm5onfQ8z6+mGylVj5KWctmZ1avxVNobQQItv+vLhz/dYyMKtv4zE8BP/Vv942vzcyG8lZO+E61oSnzX8me6O390upRR0e9e1jqRt9GVZPKMlYBhUrT9pHA/PQjoeTFl1yOP9PtUF1J0wv+O+EMgPpJ11AxJGe7fBCQZwbMFQ/RlLes1FJDb1Mw9qhm4ZAYl3YbOqsdA2Fqdd/iY+nRge0z7CW2MvSWckZ+XlunFzTfyhxP/97Uss6TfwR3aW87Ju1ui4qiBq2UFWnXtv8zAQP3dTZQuPOsrAl6uymu3TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5646.namprd11.prod.outlook.com (2603:10b6:a03:303::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 24 Oct
 2022 21:08:54 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%6]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 21:08:54 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Topic: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Index: AQHYjHDb+eGrTrYjV0q4Ak2q6+c136159KGAgApwm4CAAFH9AIAXBOsAgIKw4QCAAEkuuoAABiIg
Date:   Mon, 24 Oct 2022 21:08:54 +0000
Message-ID: <SJ1PR11MB608390D539CD4B405A195344FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-2-yazen.ghannam@amd.com> <Yr2CpuL+JHWblJMD@zn.tnic>
 <YsxefXQDCiJ1zxLG@yaz-fattaah> <YtUgb2Y/H/Wq9yIn@zn.tnic>
 <YtVlNrW58cFmksln@zn.tnic> <YukW/IltcCRwvSM4@yaz-fattaah>
 <Y1a4prRIYNw8GIkm@zn.tnic> <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com>
 <Y1b15vnE/Pd1U4r8@zn.tnic>
In-Reply-To: <Y1b15vnE/Pd1U4r8@zn.tnic>
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
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5646:EE_
x-ms-office365-filtering-correlation-id: a213f439-7d56-46f4-c1dc-08dab603f52e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JkKZv1zITrzJsQZ1E6usIcU9ni5AEJPBQa6D0sDQRqtYC35bE1YfUxI+g6mNwD5t2l09nrNT32+Q5yDmiWBf6jIPOxfz/zhj6Hh8wo2PoXL8700XnLNF/axW2KYbUI/O5M1tiaEpD8oofNiLVYcdk2yPe4nLSlzy2HAbJywEQj2XsYcbx9TpceJoH44QqItIWbPo6SQ+2RcxJ3vWzRy/Sy1rXhhXZxg4MSgQ6HCEQxWgQVCeSUlOVGdRjsHCN98JBcyUmUrT+e+LUXrFmG8SQns/sPeJDuA6ppv9D2oAMOIfT7t0TJZ7xGA3xC9y1Z/gj/KR2NidieTSdjPneMkqb4mbpNADpuxhpb79pPDmA4GDyNjhVW9WraBpnEcVScCAOc4V2JMwlK1CMurbxQPl1X1ffFL8r5+amDy+ceVJAYKi0DGQxlGH77+uQ60OZn+kGo6z1/o6T2qFCP5hexBCHCfvsAIvANcUaHyM+YaAv9VF1kmefuWwTW0QXQ8HzHRz9PpwaWIyz2i4Rm3+T9CWgBr7v83qPo1achpYYvh9sZD8DDRJVOah6leLrDsl1/VJ2FJpBbvpwewNCQDH0Zx8Tw47anqusQpgO5bZXWY3B1nKeLsl54pB20NxxGvipnTjkgCwMfPtJ2inEzJUsCyGoxD29sMab9PoZZ6OZvhwp6rpAC3O1wVLWnRK4Wpjav5fMnKzSOL5ZSRWZdY3s6i5p4erFkfwbbDsx2k07+P9sDDJ4F3iiQS1GGEDaAmxKyFO9e96lqP4ScHS6/h6O9Ss4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(66446008)(82960400001)(4744005)(76116006)(5660300002)(66476007)(66556008)(66946007)(122000001)(8936002)(38100700002)(52536014)(38070700005)(33656002)(86362001)(6916009)(54906003)(26005)(9686003)(71200400001)(316002)(55016003)(478600001)(2906002)(64756008)(8676002)(41300700001)(4326008)(186003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHpuMFJlTG0xekNMbXlhM3JVSWdVNGNXaU1ROUErUVp4OGhMcC9XTmJ2a0xU?=
 =?utf-8?B?RjA1b0t5THgvSktaa1Bxc3ZlLzRxOVh3bHp0TXhvRnRidWsrNkYwZ3I1V3hC?=
 =?utf-8?B?d01QSWNlWnQyaTQrdlRzRnhWNEcwZGY3SXBPSk93dHpjcVVHbWRyMTVIUFF2?=
 =?utf-8?B?bC94bVFOa0prdnNoQUorbVVGZzA1dDVHTkVwL2E2dGRyWGtmUEdJUnBNckxK?=
 =?utf-8?B?WE4wM2MzaEFyQWM3ZEJhSVFSckk0ZTNMQ0c4VVc5d2pwaDR4SGtSQ1lOK0tJ?=
 =?utf-8?B?QklpRnIyY3h6VW1oQU00UHhuK3hQU0hLdVNsK1N0SDZ3S2lmbDV5VmxyVkFF?=
 =?utf-8?B?dEthQlEvcDV1U2FQY3Z6aXZETUpIN1I0WjNuUDBoclVCMnR0QnNQTzBGMnJh?=
 =?utf-8?B?ek9ubVIvdzBVamdLTTNKREFEUlNMYmFEL253MFZsOGVBMGJydTkxOVNGVkFX?=
 =?utf-8?B?R2lFZzB2OVpieXR1RGUzdGhiWWFHcWp5Nms1cUtubFpuSmY3bWU3dTlsMjFD?=
 =?utf-8?B?TklrYTNLdkVXSFIwOURUaUU5SHl3VUgwdFlSejlXZjNNaEpUc2pPQUVBWm5S?=
 =?utf-8?B?T1ROZmdmSk4vS3QwRlJ1dnF6QlkxeHlDR21JYXVTU1JDckVBQkJ5RXpsMUt0?=
 =?utf-8?B?UUk3YllYOWVTOFg4OGpvc0tzN3ErZC9EdUw4WE9SbmpBTUhRQytRK1JpNVo2?=
 =?utf-8?B?NGoyQTBTYnBmVTRNc1ppWDZ5K3pRcGFFeVRNMFZiSGJNR1pxTk9qOUczYjhD?=
 =?utf-8?B?aEVSWWhaM1JxbGdPQmxkYTRZQmtWOUd1VmJMSVNlUDE4NTRXdFdpZHEzQy9R?=
 =?utf-8?B?MDBSdlJtTUxXdHB1YXJNQVNnNVVXc3l3eEt4bk5JanpZRU5PWEhEdXFJY0tR?=
 =?utf-8?B?ZTlCUlg3QUFQWlFZZ3kxSnkzclNFeVJ2UmxKUXB6RVJYU1owWjVqSndjaUx1?=
 =?utf-8?B?dGhsT1EvVjBNZGVmSFhzSi9xUDJsQ2IxcURlODN1K0dndWdqenpRZHVpdWJm?=
 =?utf-8?B?U1dBeFB0MExMMHN5cWNMb1FaTWxna0hOYnB1d2VOWmdsYUo4RzljQk42cm85?=
 =?utf-8?B?TkFHZ1VrZk9MWmY2NFJYYzgvV0pYM3E1SzFZckJBckxIeEpQZy9QY25SdVVS?=
 =?utf-8?B?NzBHUjRMTWJWcFJLM0wxNU50bzZBdEV1ZmZQc2tNOE5EL09aRUpsVjRNOE1j?=
 =?utf-8?B?VmpFRTY5MVIwVjdxd0NUWlFheGFXSEdZRllWei9ScVlGTEV0OWdrLzkvTmpk?=
 =?utf-8?B?TWloRjc5RHdQWld1ZWE1Q0ttaGxWTWlMMDdVWEcrSDR2RnBCOVpEdG44bUJv?=
 =?utf-8?B?U0tLdVFYWEFzZTlTckFnN2FtSmlYYzNQZDZBbVpLTXlBbnlEaDM1TlNvRGZ4?=
 =?utf-8?B?Q2FXR1JNUFFIL0lXVFYzSnpFZVhUWEU0TFdPU3JRSFIvNHY1dnNodkREeUFw?=
 =?utf-8?B?dUQyZ3hkbGZDcGcwZS9uTU5xcGNqYW9RZWI1ajZFL3lJWFZkd2JXZDZaVWsy?=
 =?utf-8?B?WDFXR3JJdTlZWTlPTFJ0bEN5TFBtWENpb2VFSTlVOEV6TTZIbVFMQTRwY2R2?=
 =?utf-8?B?UEpIVGlMR2NhOHkzVUhkS0ZyWHNrUkp6VkRyRHJrS3RMelFHS3RPZlZVbTcw?=
 =?utf-8?B?Mis3ZUJRaFJhNkdjYXI2MHk1bXEwZi9nQVdJNGlHeWRLekR0TU9FY3hpZWZG?=
 =?utf-8?B?eGhxQ3VsSGd2REZncFJ2YW9tUERwbHBybDlrMSt6cklJNjUxNGxnVFJ3bjFR?=
 =?utf-8?B?TlcxRC96NVN0RXBycWZraEpMYit6dS9RUkY1VHY5L3pubG1EUXF4d2Q0K2hO?=
 =?utf-8?B?ZlI5MmgzcEkrSnF0SDU4ZndKcEx0aTFMVkZ2RHFzc2xsWUVqcW5yeUV0QURM?=
 =?utf-8?B?NlJUYnlzUVN0MmFZdG13aHpuUzBaRHVocGNnYVVHM3JlZUdCTHRMdHJkS21l?=
 =?utf-8?B?Rk1ZUFZjNnpDU0ltdi9pbnBNL0ZVNmlJUldXd2UrQVhlNUI5M0hVYlFhSjdN?=
 =?utf-8?B?VkNUZGthR2hFeFF4RngyV2dGNi9XcjZZNlRERnZ5ejI3MitYb1NWdzRoL0FS?=
 =?utf-8?B?bmZ4b3dVNjdLWmRsWmVOZUVDZFRmTHJPbFd3U1ZqNXN3Ukp3RERhbkdKaHdJ?=
 =?utf-8?Q?Qx149hulKj3VZpvRa5o1aon+G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a213f439-7d56-46f4-c1dc-08dab603f52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 21:08:54.0673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzbLH7EmOndlWgala68Nv6wkGRP1qwSkz57i68eTeks+HMksh0w+PpojdwdBTPUp4aBObhCiSh4ajJPCi4MzKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5646
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

V2UgYWxyZWFkeSBoYXZlOg0KDQogICAgICAgIF9fdTggIGNwdXZlbmRvcjsgICAgICAgIC8qIEtl
cm5lbCdzIFg4Nl9WRU5ET1IgZW51bSAqLw0KDQpTbyB0aGUgbWNlIHN0cnVjdHVyZSBjb250YWlu
cyB3aGljaCB2ZW5kb3IgY3JlYXRlZCBpdC4NCg0KPiBJIGd1ZXNzIGEgdTggdmVuZG9yX2luZm9b
VkVORE9SX0lORk9fU0laRV0gb3Igc28gd2hpY2ggd2UgY2FuIGV4dGVuZA0KPiBsYXRlciBpZiBu
ZWVkZWQuDQoNCkV4dGVuZGluZyBpcyBoYXJkIGJlY2F1c2Ugd2UgYWxyZWFkeSBib3hlZCBpbiB0
aGUgdHdvIEFNRCBzcGVjaWZpYyBmaWVsZHMNCndpdGggc29tZSBnZW5lcmljIGZpZWxkcyB0aGF0
IGZvbGxvdyAocHBpbiAmIG1pY3JvY29kZSkuDQoNCkJ1dCB3ZSBjb3VsZCBjaGFuZ2UgdGhlIGN1
cnJlbnQgZm9ybSB0byBiZSBzb21ldGhpbmcgbGlrZToNCg0KCXVuaW9uIHsNCgkJc3RydWN0IHZl
bmRvcl9pbmZvIHsNCgkJCV9fdTY0CXZlbmRvcl9pbmZvWzJdOw0KCQl9Ow0KCQlzdHJ1Y3QgdmVu
ZG9yX2FtZF9pbmZvIHsNCgkJCV9fdTY0IHN5bmQ7ICAgICAgICAgICAgIC8qIE1DQV9TWU5EIE1T
Ujogb25seSB2YWxpZCBvbiBTTUNBIHN5c3RlbXMgKi8NCgkJCV9fdTY0IGlwaWQ7ICAgICAgICAg
ICAgIC8qIE1DQV9JUElEIE1TUjogb25seSB2YWxpZCBvbiBTTUNBIHN5c3RlbXMgKi8NCgkJfTsN
Cgl9Ow0KDQp0byBtYWtlIGl0IGNsZWFyIHRoYXQgdGhlc2UgMTYgYnl0ZXMgYXJlIHVwIGZvciBn
cmFicyB0byBiZSByZS1pbnRlcnByZXRlZCBiYXNlZCBvbg0KdGhlIHZhbHVlIG9mICJjcHV2ZW5k
b3IiIChhbmQgcG9zc2libHkgYWxzbyAiY3B1aWQiIGlmIGEgdmVuZG9yIHdhbnRzIGRpZmZlcmVu
dCBkYXRhDQpsb2dnZWQgZm9yIGRpZmZlcmVudCBtb2RlbHMpLg0KDQotVG9ueQ0K
