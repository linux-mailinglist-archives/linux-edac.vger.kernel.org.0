Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA7073356C
	for <lists+linux-edac@lfdr.de>; Fri, 16 Jun 2023 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjFPQIx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Jun 2023 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFPQIv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Jun 2023 12:08:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DC72683;
        Fri, 16 Jun 2023 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686931730; x=1718467730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Iz6gd7TBkUB5SvRcm6cBZKVTBVDUh8iG3QyrG3ZIOm4=;
  b=TIJQ45UfsNesWxQYp97hfY1E0QMGlHQdm0/2ud6QZVHygXHeNvypRHwU
   9gbQ00H4RWJe/0P5XgN1VaUEk7NCa5RTNzXSNgB3XPP1VIkvdaXW/l/7t
   C+IAdCOkz3H1cCANO3YQlLTFrqx2Lg5V645NT2sNxtP4joCsEZJX9HM8G
   MtGo7mw3kMu9+LHGrS0YUJxqxkjZwUsfDwhhIe63Ih7VZJIO0R+EIUqDh
   oFd259hXO30q1rUTn/EDEjPBxXbVHSVv1cyfN9da0F2vhDxalYPXF9Tig
   oRvQaCxd5hHyhmoLjRUZgmTKLLlEU6uqLND4WXijTs2Xgr2lZydaq7o1h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="362663610"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="362663610"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825785962"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="825785962"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2023 09:06:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 09:06:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 09:06:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 09:06:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 09:05:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWL6InWadImGsca41bfByVyq5c1yhU0nnhEydZiTgmoP0jnZYUtXJefrFGDTZp4rl2SoAjX6TpkCsLhepCYz0eArz+UrpH1LCv9nkcsgjmaHxX6lDfaKTkms+pcVdi8YuK302Dt41+7kD4sXKzEo34EMXANzOCJJtDFWYzwa/Pe5ritDlqN0my9tc4ZPgDADxIsam/EDN9YML+4pZfRUs3UGkzX1bjWfZQV0FrCLbeTOsBqwr9Ps4DKytwCdOoTkf4dqc8q7qoZkPsufCpaKL6WsCKti5Ig0ClO0Xt5zUCqADiHsp0gbH/5G4d00TP39tSrp5FqhNLP0liq3xbWR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz6gd7TBkUB5SvRcm6cBZKVTBVDUh8iG3QyrG3ZIOm4=;
 b=fVOiumQppcaTcJM6NPsbYU/RwjYh1T5BcMM+wp3Q2p82uGXJ3WLyYu/ilwsib0C3x0/2qmNAkKvwzro41JFaFeHPLgh+3vWC1qODI4GBAqjE2aDnc7FFVd1ojAmuQSswLTTjZwoXnj+lcntrzbHupWfKapaAtxl1mQwVtVshpFVYa2c6fLax+PfTA2SXuRyiLvcj8d1QvupVpwY7fVwgcQFnf5olDJKc3BvVtVdMkoePUAsI5ymPqYcfcELZejar/mYxD4B5wKNmGA/05Hz4vdRGlPTTyFZCZoKlT12djBDOjAKH93MKkGtWdTkKheMWsrVMCwuVLeG0SnDAyEFJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6675.namprd11.prod.outlook.com (2603:10b6:510:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 16:05:52 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 16:05:52 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Thread-Topic: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Thread-Index: AQHZcUiOiGs+Y9zOZU23tA/yQJ0VrK+MV0eAgAAD3YCAAAztgIAAC6YAgAAKcoCAAAIuwIABV3uAgAAdzhA=
Date:   Fri, 16 Jun 2023 16:05:52 +0000
Message-ID: <SJ1PR11MB6083BCE88F98E699FB9FE04DFC58A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
 <20230615152031.GCZIssPyJjGcikn9iA@fat_crate.local>
 <c9f885df-4650-248c-3708-9250a0b530dc@amd.com>
 <20230615162037.GEZIs6VZG9gVs5QtFT@fat_crate.local>
 <d1333fa6-34e1-8b2a-b772-369776428eae@amd.com>
 <da1f680b-f601-0e64-bdb4-1aa5b6fc6175@amd.com>
 <SJ1PR11MB60834DD80A6193F959719CF4FC5BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <471df10c-782d-f251-f8ff-59b01ed097b2@amd.com>
In-Reply-To: <471df10c-782d-f251-f8ff-59b01ed097b2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6675:EE_
x-ms-office365-filtering-correlation-id: a07f7ce5-e372-4443-7447-08db6e838f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hahbCLm5HAzOrsTh7su2/CqOvzeYJpoSvwn1FPY+0IhiYrubFduDciMgs3yXdjNfVbcFFILY19JPfc0vhp1ZodQz6X4D6NZviDfjZHCzwbFDH/lcaWCEN5HSpCxotDkz2FUhJwF3dXjoNENx1rcKAt3N+0KdqLfYr2W9L31KkLdarFrALV843RrAkJpOOlsT+zFOtLHhOnYhId4gN7LQAlDYgdbMXCPwewBYpAGoPdOe3h5TqUdRvr5Syk+CBMsvFC/DU94orSiiF8vLpzf6ZP06j5h5Lf55s0+W8tf6PXexXGpEMu7EL4jb9OnslHOgG2IHiF3FT9gcYHQBLl1XRCtuGrHVXtwJeq9Qq27Pp24yuYNaEIp3L4+jWffQgzX3ODuyLyfdyX3MP0MaXNjzy3uKEboLnRl5Z4k72uBwUfGGJ95BJQsCAg2i8kCqxx7b0qO3/XJmy8xy/2xDn/2jxRJy/tePCtjqPXmJrknA0dgrI1kMJ7Nsb3DNIZLPGCW+Z3NB44wWbW1gDdwBvZTLjG8ah00q+Pg6KzfH2kE5l+4uRAy/9bRFrCoNgXJ4OKGuKNcXL9GNiVbEnhdO3twySwPZPcQ1VVa1e7uMeduvQ3KKzlbPlKJ4UtPoYE0zm09n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199021)(52536014)(5660300002)(82960400001)(38100700002)(122000001)(186003)(2906002)(6506007)(478600001)(26005)(38070700005)(9686003)(55016003)(66446008)(66476007)(33656002)(64756008)(71200400001)(8936002)(558084003)(316002)(66556008)(66946007)(8676002)(41300700001)(86362001)(7696005)(76116006)(4326008)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFBOWktqMExwZ01BamtUeGtsWm5ScVlRT1JiVnBvbHk0QkhSdFlGZEtiZElO?=
 =?utf-8?B?T0tWL1UzT2xyYjlxajZhOTMyMXNVdGFqZ3Y0RDZIdS95UldyQjM2WGpOek5X?=
 =?utf-8?B?Kyt4WktMbzZ0ajZzSTVFRFQ5bG1kUnNBYkFUU1lZd2N1eGNtMjdOeFppaHZr?=
 =?utf-8?B?YXVFVHR4ZzNrZVlxQW0vSVQ2MXBZcXlubHd2VWx5emkvRHJsZ1gwVklIVzJK?=
 =?utf-8?B?cEVSZVFEcnJsdXNnbEdwdmt5c1JtbHNpR2FoZ2lLc3lzOWRRd0ZHKzFuRDFC?=
 =?utf-8?B?Ym5oV1VHdFVKU05FSUNJWUw4aUF3blQ1REU0U2NWLzRORksvZ3Y2Wk44aDAw?=
 =?utf-8?B?RWttOExNRjR3a0ZTOEZBeW82VlB1bzVHdmwvTE5EZFRjM0NpME1PT3d2Mlpm?=
 =?utf-8?B?WnBPZlB3ZlVzZ1JBeUpHMXpmVVJ5eFQwTDVpYUFkQllJbnUwaTlFVXlBd05J?=
 =?utf-8?B?M0labk5LcjZwZ0E2WnVsUWhvM3QyWm5aMC9YbGZwbWc5TTJEQWhYRm9ibFRl?=
 =?utf-8?B?d1FEcHA2SDRudWtNb0paRzA0TTBrYkJBY1VoZnk1cytJaHJaV25Kb3FpRDZL?=
 =?utf-8?B?MDByS1E3RFZjWUFCU1cwQTBESXRLL2NjZ3BwRy8wbUY3NEo0cjVSeGhFSUpw?=
 =?utf-8?B?NVhJd2lBMVVmNmpqejlkT3gveStnQ2VZOStnL0E4UDVjNDBxbFFQQUZxNXFs?=
 =?utf-8?B?NnI5MzRQbVFPeFZzQ1Q2UExBZ0IwNlQvU0lVMUNFWUNwZTVhcDFkSE8xMXB3?=
 =?utf-8?B?WW1uYjVjN2VJODZSZnRFeGI3NmVmU2dJVXBHVVNPMnEwYjRBeVRLODVMeTg3?=
 =?utf-8?B?bWpBRHR6SEkzdGdFVXpTdk1mYS9aZkJVY1REbHFXSUFUajFRMVRpcWhENnBa?=
 =?utf-8?B?dXZveXplOGx0YmcxRmx0azBEbm9PTTVkblJod3l3SlpTV1lQUWlMRC9BQmJJ?=
 =?utf-8?B?VjBwaGdXS0tBS1ZNaThvejVFTmtkQlByZTkyKy9HU2h5WXJoZ3lmTHBNNlNE?=
 =?utf-8?B?NjlGbmRDYnlkN2dNMnh0Ujh3K0tkcyt1VkNjUzl0clp0QUxVbGJTaFp5dnVU?=
 =?utf-8?B?dHJmMVZxakJLZXlwTW8ycUJScTF3emh6cnRlelZwTlR1bHdmcmsxVktRalRQ?=
 =?utf-8?B?NWNBTHZHV0dvRGVzVE5Ec2NrVVJlUlN3ekNoMW5naVQ0ZzdrMWU0Y2o1eU1y?=
 =?utf-8?B?YUVhc3UwOXBuMnl1clNQZFQ2UG5NSXd6V2h1T3YwdUpBZ0FmKzZiLzRxVGx0?=
 =?utf-8?B?cVduT3hteEtJTTN2bVFDNTQydkFMSnR4cXJvY2JkMFFOT1NYYjFsTURlOEQr?=
 =?utf-8?B?QUhoandLcDZFUTR0VkhPb2tsUXhGb2d6T1AwZW1JV2YxUVpsMjErNkNZQUJ2?=
 =?utf-8?B?Qjc3cnNGWDBpSVBpVWdNalNRUDhROCtzdEdHMVpka0kzMCtuSlJiaU1nUzk5?=
 =?utf-8?B?eHJoMXJWQXNiODJHcGlhbUJZeWhSK2hHZGRvZ08vaEhTR2dVYWVJK2dzNmMx?=
 =?utf-8?B?cmdENUxNYjY3SjFMQTJkWnJXU0toL0RCajJNdnRRRTMxQWN6YnpoTW82K2Ex?=
 =?utf-8?B?a0ZyMk5QdGErMFdUWkloM3MwQnk5YzZZR0h6cjJhOFluUzNJRWlNU2p2S3BZ?=
 =?utf-8?B?VkVsNzNGd0QyZFltbFcyMVJUWHFmaGJxZmtiL0RNd2dDR1JFbzBKaGRWQllN?=
 =?utf-8?B?clhUS1ZnMnI1YVZZTG1OV3Z3RHAwaEYrbmNFSmE2QXFOMjRScEhxdUl0MzBT?=
 =?utf-8?B?Tm5NU3NOKytHV1p3aVpWRSsza2V2ZWN5UHpGSFVLNk4yMmZkTGhrZ0duR2J1?=
 =?utf-8?B?SmRRczZWN3lOYklXZlZ4TGIwNDZsOVU0QXA4bnMva0FuVjBtcnpwOGVzKzVN?=
 =?utf-8?B?OWQzSUVCTE91NWZxM0orMHpyOG05ZUtIUEpXSjdsLzE3dnppdHRhUU1YRExm?=
 =?utf-8?B?elFVRHVSdUEyZVZsaHpFOGRJa0lTYU9EK3pZRnk4LzBFR1BhSGNrbXJlNm9w?=
 =?utf-8?B?Q3d0bEtDQlZkc1pDRzFoZ0l0Y0JNNW9haldXK0FweUtPRWF0UCtSMDZ3NjJa?=
 =?utf-8?B?VjR0K1ZmQkthZG9BQnRqR09xUjJTL0U2VXM5VkY3emVWb2ZzZlFiYTlpeTU5?=
 =?utf-8?Q?6+y0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07f7ce5-e372-4443-7447-08db6e838f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 16:05:52.5438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUkl6RxrxLHbWugGmyK9ae0lfiHRl7i1xrfowJDJ/mXXGXDY/gRCmBRGpDnJf6bXnGGxE4VH5uw9RgzncJ+HZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6675
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

PiBDYW4geW91IGRlc2NyaWJlIHlvdXIgb3JpZ2luYWwgdXNlIGNhc2U/DQoNCjx2YWd1ZV9tb2Rl
Pg0KSSB3YXMgcGxheWluZyB3aXRoIGEgcG90ZW50aWFsIGZ1dHVyZSBmZWF0dXJlIHdoZXJlIEkg
d2FzIGdpdmVuIHRoZSB4MmFwaWNpZCBhbmQNCmhhZCB0byBmaW5kIHRoZSBMaW51eCBDUFUgbnVt
YmVyLg0KPC92YWd1ZW1vZGU+DQoNCi1Ub255DQo=
