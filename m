Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FE660BE49
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiJXXNT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Oct 2022 19:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiJXXM6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Oct 2022 19:12:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D243A344D;
        Mon, 24 Oct 2022 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666647238; x=1698183238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g6cU93Y8it+4hcunJVuRegtC2VZhysn8LaBonwUW12I=;
  b=f64W4Yo+fTfogXMzPcpLwb0GFRCz6TYBWWKlj420yw8SFjAixkauklw6
   rEVbozCxGISZtz289BAbLx8OaWgAuz8Dsxc84I8LPC7qo0M9ZlpJ5xMwO
   HbjTZHlonQGVOZFOyLDyFWXzW7p/aFc7WrnVGWo2ipzgyMwK2h0bakFog
   qexwo/fnAS8tl22HnIUHd0c1B2OUTq4SSd5tuoGjN0yMRPHCnviOMqTOy
   4sXUrRT+5P0NNWk/i5iYjcfJBa6r+SCPqAv4RASkwjJJhy+hvM4KAXZfD
   4ajEVkU/1HS8njN8B3MRFWHsGKQPgrFBvJNpXLcde/8ErY1toTGfUEur+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393842347"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="393842347"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582549825"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="582549825"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2022 14:32:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:32:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:32:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 14:32:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 14:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEw53lg/UgSNrK8MGH7ibdlNetjQJa7jc5/E+8nekbf26JvMDC7kZUj8v9IM4avjdiJoiQI4lD3IqZH9xn4SAK5Qblb+Rml++VKEofHeCtReXlbzksPVhnzLKXN+KfbndnDrOxp/ZdKjuwf60h1Y5fQnKS+AdJJV5RankVwSNjj40CHLeMG8LVxT15aycUMF9IijVYI5K8xERjKHBA+zOGpQoBVvdnkNMw4YuyeovuIoQ3MJnkMbTnAB9FMsQzB9/de8lxkshEsTM4ybuXJ4fdTxGMBGbURH957KMaoF6g9RF1gmudHSR5lcVyTMof8dyenntsUP+q5HkjqHZ9No6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6cU93Y8it+4hcunJVuRegtC2VZhysn8LaBonwUW12I=;
 b=IRWEAUiCfnvrvcMnkhDVoGh7yeHULJRtqAJgB63jFw3j49XnJ+PDAOVPSFCg8p2GkbTvVAO2URXXtjlJJsTZE4K5QBedoRFDP/eWVEi20F/D0ZTCw5hcBK2svC2QlXD+27z+MNNt2rB7jf29CxkbZWGidnjIQraK+tniDgo6WyqV5vB5znEllkKd73l1pNhQuAbNbDgIXje7YTJlgvstscg4ZAWr2XDb0GrMMaQXhtNj5J9RWVsO8naeqTOCDOvw5JI1xAs7HumL0S6gHrsdo5XpE8bfAElrx4Fz2IOzOL2k7Z6JTU9IHa9cWH0WvIGEuzoFCjmUEWCEhxGbHbksKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 24 Oct
 2022 21:32:39 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%6]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 21:32:39 +0000
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
Thread-Index: AQHYjHDb+eGrTrYjV0q4Ak2q6+c136159KGAgApwm4CAAFH9AIAXBOsAgIKw4QCAAEkuuoAABiIggAAIhICAAAIP0A==
Date:   Mon, 24 Oct 2022 21:32:39 +0000
Message-ID: <SJ1PR11MB6083DBDAA90E1E03EC7A9EEAFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220418174440.334336-2-yazen.ghannam@amd.com>
 <Yr2CpuL+JHWblJMD@zn.tnic> <YsxefXQDCiJ1zxLG@yaz-fattaah>
 <YtUgb2Y/H/Wq9yIn@zn.tnic> <YtVlNrW58cFmksln@zn.tnic>
 <YukW/IltcCRwvSM4@yaz-fattaah> <Y1a4prRIYNw8GIkm@zn.tnic>
 <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com> <Y1b15vnE/Pd1U4r8@zn.tnic>
 <SJ1PR11MB608390D539CD4B405A195344FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y1cCU9UqGG7nl8cy@zn.tnic>
In-Reply-To: <Y1cCU9UqGG7nl8cy@zn.tnic>
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
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW3PR11MB4714:EE_
x-ms-office365-filtering-correlation-id: 8f60bfbe-8473-4434-6cbe-08dab607468c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: suctKAA3QztbVILDAljLHbF4LvhqDXfa0YeLJ3Whtc4dM3V7Ygbx+mebB7EGoca5LK9fxFoDITn/B1ljOnhF7HQZYcUeDom9WoXuOEXXCH/IG8wlaaLfd5hJc93VgjIRdSKixbk+tdIPChLX1r3YGPbSJQ64tNH3SSdZMKKXDLq6K27H1PP9IiEcJAtHW0lsE38/nCK47RnCJGXkFRHhc9BnjBcW5an7A/23q+AiGM2BWpN0OmOfIZCLIZBgIda/VXD1Vt1RsRDWPp2YsLbwIJ/Vh02M2kg2Mlt0l7yAh21o7kBbULYI/jDNr604idrj38/MjkPSVwk/ZrvxSMZoHca2DQrSdJ7aZ7IXaO2/3hl0UL9eQF4Sx3Mjg7viosEXLf80G2DQ4ih0V3+TM354wqzUPL8XGIuaMc7Dc97M3TVerJMjb5M25HmxV7857SN+0xdXb7G8pIwWUyiMc41udnaUX26hjZWlxBkPU+h68kXWJlby3jmCO/wdhyjIUNP4dmKjpkjKcE5XednXWvgKLUYC+DRJgYVstU4sIZ3gwoLk+EIEaWLjTigiOiBE70n0rCu3VMLstAe4LBGr4HBc2axoY1OByBiNg+x4iAacR9OPrT9+N/hE9urcuX4lsXmNwLbcfI2SNbtQ8yTNijmkR7xECd4sdmch7q0Cn5V+v7NFdXqy8WjQh90OeoVeccTTuTHx0EXAa/SXsmxHC/dlHSLlLbPQ8BE0c76dTUSxvzT9I/BM4mZuu0NlkYlA/S3mrg+Xt9u4g+RocqtcAxONqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199015)(66946007)(66446008)(66556008)(64756008)(8676002)(4326008)(66476007)(76116006)(38070700005)(4744005)(52536014)(8936002)(478600001)(71200400001)(5660300002)(316002)(41300700001)(54906003)(6916009)(55016003)(33656002)(2906002)(9686003)(186003)(82960400001)(122000001)(38100700002)(86362001)(26005)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWppMkg5bHhlV1BFL2UrVmhyRHF2RTRpM3l0UHhIdU5JNmNxaFJNVFMzVlVn?=
 =?utf-8?B?d1p1cEZYNWY3Tm9tUHQ2UU5PL08wMEtiaDZHMjJpRDVRQWlPNFZHcTRPMHdY?=
 =?utf-8?B?bzJ1Z05Zd1ZITU80ZEUyK2pXRTNFMW5USVppUFVjKzlUNy85Vit4SkgvNHI4?=
 =?utf-8?B?UmhLYjRPZFExSVRoa0NyUjFHOXc2alRNT05GWndCNld3UDBSdHA5YUl1M0Q2?=
 =?utf-8?B?M3VncHV4TkpxUklUaERNZ3VWWVdVYndvVlpDbEI1L3NBNGdNK0ZGR0lFVzcy?=
 =?utf-8?B?YWdwVXplbXRrT2MwbnlaQmtZN0pBVklneS9id1J6dGlrcHJ4cUNyd3c1c0o3?=
 =?utf-8?B?RmVQR2xKMERaNTJWTkJrR3hNRVVMVzM3MUdzd1dqT0MwZEgreTZXVTQ2dTBn?=
 =?utf-8?B?ZkhYS0pyd3BRWUdYaHJoQU1mY05FWVpwVFo0STVZNG1yeUQzb3dvYnVEVUVk?=
 =?utf-8?B?V3YyUVZ1RE42Q1BpV0g5ZWs4RVkyd0tqQnBwdkZ1OUtFSnphSnE3QmRueEFa?=
 =?utf-8?B?d0dqMWJadm1vWmpvQ3IyQTNiNmxtc1lnbzRWaGd0NHdaYi9GZDY5anNwelZz?=
 =?utf-8?B?Z2FydFVab25BcTF6Z3kzT3R4LzdVZ05ZMUtDWExoMElGK2NUODVHbEtaREl5?=
 =?utf-8?B?SzEwdGdTN09qQXVFNEprR01vOGs0YVFCN1ViSVowclBLTkIvNFErb2FVZUpj?=
 =?utf-8?B?WHVaZTFOWlQwN3RyeU90dTlKbDN5Z2J0MmtHa054K24vVmV5ckdBclFYdmNm?=
 =?utf-8?B?aFAvZ0F5UGU5Mmsrak5RTWtWYXNyY3MwZDQxczZWRUNNT0NkUWV6dVhBOUxp?=
 =?utf-8?B?cGhDdnp5V3RZdmhmTkV0N1RMZnBaYjdvaHllcFo0SHJ5bXFHd3JXdm1abER5?=
 =?utf-8?B?SkNEbElwWlNnWW11OXNqdnBOV1VqRmNHdWZlSHZUMUpwVUxqVmVldjc2V0RF?=
 =?utf-8?B?cStlZzkzVW8vbDkvVWRaMzZ3UG5HdTZqR0lOMDByY3owZVBRYjF6N1BCdUVX?=
 =?utf-8?B?RjlFMGFqS1E4Tkt6MXpJSXJOVWh6NEZJbHROUkxjUDRWeXozVmE2N3dHR01O?=
 =?utf-8?B?M0hIVW9jNzVLdjVUMDJqb1FZRjVLMG5sR3MvMjhlWndsRDBqYTkzbTJvNmxC?=
 =?utf-8?B?ZlAwdWo3SjRBWnZ3cERWV2tWMGZ1VnJDWUJQTGl1V05aVGVEa2dmUkpJNmZh?=
 =?utf-8?B?OXNpUTJoTUlRSktROTB2UktabVNtRTJTUkJSekxmVzZOc0JzNWg2UUJ4ZEhk?=
 =?utf-8?B?ampSY2w3cG5MaTJUdDJZengvSlo4S2h4MmIwQkxXbzJxZXlncXppN1JKUXNQ?=
 =?utf-8?B?T1MrMU9hTTlMak5qSWE2eVZ1bnZrejhqK1B6TnYranNoWEpCMTNKeVJtZ0JL?=
 =?utf-8?B?a3h6c0xCaDRWdUZEU2F1T3J2QWVneVBIcnluaXFGd0VRUDB3ZTd4aitURzln?=
 =?utf-8?B?Qm1jcGduRVJsLzl4RmRLVWIrUFM1QmVDOWQ4NkR1SEgvQVVqZ2ZmNWFnNUp3?=
 =?utf-8?B?cGRJMExhYVdJcUJxUWxVemhkbU02NThaNWxZb0lndFB6ZzNEaEVVcnBwQVZP?=
 =?utf-8?B?aHNzQ3ZiUkgyS3RXQUhZT1lKSUZycVl3VzFBRFhRRkVIYUUySTlpNDhsK3Iy?=
 =?utf-8?B?alRXM2gxbU91TDh2RlJsSDlIcHhIbVNVWXAydkZ6aUxmRk1EbHloVUpBdlNQ?=
 =?utf-8?B?NGQ4ZGc2c05FenNSckxoaFRodDZlaTlweEx5Nk9YSmVGRGw0Q0pJMFptd25R?=
 =?utf-8?B?aVBHeGJPMlRHVmpUcjBsZW43b3VJelh2TXhhRmY5bjR3R0w2Nk4reG8zMUlP?=
 =?utf-8?B?OWdrOWhJbVY1WlN3THVkakRXVUtZQlZwY1JCd3cyQjRzYmxpR2NycFZOUGpQ?=
 =?utf-8?B?QVhWbVFVdFQ1MWJWN1YxUzVMZmQ5ZHZEajMxS0RBSFlxRE1hckdIbVF6clhY?=
 =?utf-8?B?TjRhbDZ3RGxhOXpqaC85SXZQbVBpU2VydldqTGJJYXlXWVNoTFlFZll0VHo1?=
 =?utf-8?B?b0tvbDQwVUJxT09jUGIwQTFJc1ZLNmlpcVlObGVQczVXSFVCNDl0cy81ZjFk?=
 =?utf-8?B?aWJ2MEJudFNuQjkzSkdIS3lUdGtSSHRyNE5XZm9nUjZkVmFkcDFrZzJLS0M5?=
 =?utf-8?Q?v098zyM0aL91ATiRdcw8RhbCO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f60bfbe-8473-4434-6cbe-08dab607468c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 21:32:39.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8AmQCcMOEoZWdhD2/CTsnzmufkkelI8GSq6MYGZmbYz1ED+XfTBaIQ4noK17PL7MY5fWkFpagZjmCqQhmu86A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBUaGF0J3Mgd2h5IEknbSBwcm9wb3NpbmcgdGhpcyBwcmVwZW5kZWQgbGVuZ3RoIGluIGZyb250
IG9mIHRoZQ0KPiB2ZW5kb3JfaW5mbyBmaWVsZCBzbyB0aGF0IGl0IGNhbiBiZSBleHRlbmRlZCBw
cm9wZXJseSBpbiB0aGUgZnV0dXJlDQo+IGFuZCBuZXcgc2hhcmVkIG1lbWJlcnMgY2FuIGFsc28g
YmUgYWRkZWQgYW5kIHRoaXMgd2hvbGUgc2NoZW1lIGNhbiBiZQ0KPiBmb3J3YXJkLWNvbXBhdGli
bGUsIHNvIHRvIHNwZWFrLCB3aXRob3V0IGhhdmluZyB0byBjYXN0IGFueXRoaW5nIGluDQo+IHN0
b25lLg0KDQpJIG1pc3NlZCB0aGUgcHJlLXBlbmRlZCBsZW5ndGggYml0IC4uLiB3aXRoIHRoYXQg
aXQgYWxsIG1ha2VzIHNlbnNlLg0KDQotVG9ueQ0K
