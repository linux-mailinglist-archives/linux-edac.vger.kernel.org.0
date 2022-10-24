Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C660BEA5
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 01:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJXXcf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Oct 2022 19:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiJXXcE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Oct 2022 19:32:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A44A15383C;
        Mon, 24 Oct 2022 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666648386; x=1698184386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=99FZKCAJKmRWXelv62G0jylMC2lqN192gDsL2yI/1W8=;
  b=NJEe5HQ8GFfaBpQPALUuWnxLD94EwnzDnG9wTLGjmM3UhRwSawuSYmK/
   7c5Lcf4QFXYtCVAux+FQnH9dCCPFKfDI7CYy9WNs9dAOpRH/1Syl5YbOz
   g9JBrmOHDRG53R7JmFAz470DEK/GQvZIkRQ+74udfu9HaOQ/i266iraHv
   JfBMXDW8F28cWY9U6BaWdLatAFqv0wyJ8+e3bq8R6v4vEC8FUtvVJcsex
   eNjPihCf4U0Q5RTaBYkWhv/qZwCCVOSB9gW3qhwIb2fq3NMgLE41qanl0
   +6kNGpI00/u2owwBhIOBCzekuZp8SkWnf6LLrYYgaQ51sDqG/1T5X1cUr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290833864"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="290833864"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:52:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="876578711"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="876578711"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2022 14:52:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:52:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:52:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 14:52:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 14:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xnnv3OhIMjuOf9zn7r8rMcln0viyy3yFoyCT6CZyR/13uTZLFtsew0qkvXKS1hDn88MibfCbrPEFBrh0Og3CysZnrBxR7ET9Jmk7THZYfsJy47YiNeuktOE5vcZpNBfu76Phfqr8ZoZjdj3PbyOFAUJyQr6WGKMtb5nPuKRON1z+h24ZuENzP/V3AcWtjylaqN4CNS9IP3vj8SsL9YNu9OnuEe2D1icv8n9sYfFx+dzTDLMyyVi1seRWI3K1/HxrrXW83cq+pxStEMiE+6RiB+TxYFbKyk0Je2czZrqka8MAf0p+kMb4YktOdD+pXshY8OjuwsqaJrAI/iP5QaZ1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99FZKCAJKmRWXelv62G0jylMC2lqN192gDsL2yI/1W8=;
 b=GSKmRUX+h/qNuM5CNMskwQvnGCEq+5iKyliTKJBZNWNg5s4o022SQtYqS8Rf1dDaBozuJi3WUMoL8BjUi4yQB25AhJyLSZdVBz325dAm0dbqZBpsSzqFMxIs6AGvArg1tOlsBV2DTHmNyR4IDXYVkzCr57mAvXzvuEUHje37oHMfDnjWZK9FtTo121XlVJ4Bn0eb9bU7vJlP/tluNJyS1hXkudUdnAZFFa70SqvofAcBpFoDp/AfqAJ0/DoffyeuvoMNW9Tbl9ef+hOEITamSp4xuwoBqv+4lwQeA36pAoVbw4GqkNd54rEdrsSodGc2qPsJgSWxGBrQeKnVvAxwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5439.namprd11.prod.outlook.com (2603:10b6:5:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 21:52:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%6]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 21:52:45 +0000
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
Thread-Index: AQHYjHDb+eGrTrYjV0q4Ak2q6+c136159KGAgApwm4CAAFH9AIAXBOsAgIKw4QCAAEkuuoAABiIggAAIhICAAAIP0IAABBTA
Date:   Mon, 24 Oct 2022 21:52:45 +0000
Message-ID: <SJ1PR11MB6083A794C876D6F44E530CAFFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220418174440.334336-2-yazen.ghannam@amd.com>
 <Yr2CpuL+JHWblJMD@zn.tnic> <YsxefXQDCiJ1zxLG@yaz-fattaah>
 <YtUgb2Y/H/Wq9yIn@zn.tnic> <YtVlNrW58cFmksln@zn.tnic>
 <YukW/IltcCRwvSM4@yaz-fattaah> <Y1a4prRIYNw8GIkm@zn.tnic>
 <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com> <Y1b15vnE/Pd1U4r8@zn.tnic>
 <SJ1PR11MB608390D539CD4B405A195344FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y1cCU9UqGG7nl8cy@zn.tnic>
 <SJ1PR11MB6083DBDAA90E1E03EC7A9EEAFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083DBDAA90E1E03EC7A9EEAFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5439:EE_
x-ms-office365-filtering-correlation-id: d13cc447-864e-482e-a2cd-08dab60a15c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZN6954246wo4FcNgVHFYYqoywFyi0ZTXZqDakrtxI8M5UFAj7FEMqC7xwF2Uw7d2QIMEx7IVgXhYVSnQ1TnpHiiJTlpvYbioGFUBanPCp7rUXbyhmA6tnMcALqjSgGkdVVFyOr4hUag2OCDhLE3aN7/89MAjpU+vk/c3khcaJQZL3a7Jp1lfbIM2w8muGqsMQQtOLf+UCI35GkVul2uEZT4/fhBuFVYmxaWr9omz2kP25WuEXmpAQ8oE4AJg5x1P92EG3SrYug9YEuwu7ElMI4nGnpyGa2RPcJhwzrI4aKVhRHKnLRTmx0FCIWp1BYxcZsQbAnOqfYgL4GDlWgqqvKMhAJ0TlI/wYR5cUhDAbErl26H04MrzAt0M49QP8SckJwU2W5R2klWaevaiRr/TRMkANjsuiCJ026tCLwa3DDJ2P1PfwwFiSrbSN6VLT4X8UkDKj8sztTcu0VinQGxoeJeLySBRW4y9tXo7TZMU6ip+xMk57kYtEQIbH6mA28sJkr6JVPj5sjGeqhonr3lY3UYfN5xAnPY7zu3tPMEYiUEmG0cS/bBZi0bNBm3QnIz3onqvPdX/IwROtZ7Hkuo160gSHeL3XUxnCIJEtvglkADMT6pBVe5O0DaCbtTX4ISnGDkzIteQ8YOyXX+TWkKH+tnF503YB/NxFa284lAwiNxz/BxnUaxl3LD6eXghOkxBWjbJCFX/1eLsu4UmaYPqi2QIqg+aeYr0ckLAj3q7mJw0Wq2LyYiDQO/xEdqReaHKKl1ZSQXJUIKl6NJXRFm4dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199015)(26005)(2940100002)(41300700001)(8936002)(5660300002)(9686003)(6916009)(52536014)(66556008)(66476007)(64756008)(54906003)(66946007)(66446008)(6506007)(7696005)(4326008)(8676002)(76116006)(316002)(82960400001)(38070700005)(122000001)(38100700002)(33656002)(186003)(2906002)(55016003)(4744005)(83380400001)(86362001)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enpETXFtVmNwWkZkMVBlYXhKSHM1b2orQUxCMnBaa1NhZy9pUnVNWnpiK1E1?=
 =?utf-8?B?bFZYZHRBdHk2ZzVhdEQwWDlmdkFoVkQrTG9wRHlkZnBaOHpLdTRiNHRWWjdy?=
 =?utf-8?B?TXZpcjk1YkhNVGJoSWwwNzd6RmZORnBRMmdDN052NFIzQ1hqK09abDVESFkz?=
 =?utf-8?B?azRFR3pTbHkvcVJiVHlVcUI5SkVmN2JpdWpEb2cxalpZYThVREhpNjdLRFBN?=
 =?utf-8?B?YjBhd3Z2eHhxYkVBa0w3dDZyRHJpb3VVN21hb05DZG9JNmtMOVhubldsaVZJ?=
 =?utf-8?B?WTBxREpsbWFGQS9qM0ttL1B5L1hTN3FDUzNmSUw4dDVHVzYxZEltR2N0Qk9S?=
 =?utf-8?B?UTA5MjhSYUxFdTl3OVFKSUdQd0RzSit3WXFZOCsyQVcrdjFRTG9OeU5CWlB4?=
 =?utf-8?B?UmpYajFiWWE4dyt2RzhUN1Yyc3dESzVsbWFaT2pXdVNoeFEyM21GU2xBa1Vp?=
 =?utf-8?B?Ym9vcTdHWEVFNVBxRTU4S09CT2xwbjU2QlZncmZRQnhwQ3hkTVBBNTZSSlpJ?=
 =?utf-8?B?Q1hiUGFtZkhleGd0aUJsdDNpT3VzWHRyUGNBcEpQU2J0REtvZXF5RmxqVjRq?=
 =?utf-8?B?bStJVC9hd2prLzlpaGgwVXBsN0dhOWJmUTZEY28vSzBDQ054cXZxVkZzclVj?=
 =?utf-8?B?WDY0WEFxbWQxc2FkMzlYQmlsdTFjMEpLenp0YXkyMlAxSGlTOFcydlk2K1Zz?=
 =?utf-8?B?eko3VXFHTURBQXdqNDZINktodDBxZ1A5SnNxT3hkZmg3RXVPSHlkemxWVVhv?=
 =?utf-8?B?bGYvREplcHIrZ1c0MThaeURMTC9vYmR3WjZubHEzTlZ2cWcvclhnYzgvNUxF?=
 =?utf-8?B?YStHMStuaTh5dEpaOWdIYTM4VjNCVWM5Sm1LdGpYRlJJdFA2ZEJSOUI4bURF?=
 =?utf-8?B?M2tHNDNnV2Y0T0FzTGd2em5jU2dTOEtCajJ0eVdVMG5XZmlDVDc5MFd6L0ow?=
 =?utf-8?B?cW9TUWRzbkdZaWNMSzVHSnZJeUM3Ulg1RzZBNGVwSC9LNGJ4KzZWNEx4TWRp?=
 =?utf-8?B?d0pNNmsrb1FWSkRsOGZ5WUJlZjZpN1cveWNCNTFRUHpxMkVGVGk0UXd6eW83?=
 =?utf-8?B?akgzZ3VIMVBpVjBDN0NuNDdmdG8xVVU3QUd4R3RSLzRobWhlUzA1TzdRQTJD?=
 =?utf-8?B?SVQ2QlZKc05GMnJwWmgvc0k3S1VpbFZ2K1RzaUdld0xKM09HenFmZ0h6MGJW?=
 =?utf-8?B?UGFBN0x4cGtSb0p0ZlFpQkN6R2lLWGh4Qko1WENNK0ZyRnBFTFYzNm9MT1NJ?=
 =?utf-8?B?a2U4eHVLZEFydytDT2ttQzBQRjl6Wi9lbGFwWmxGZGYvRHRPVHZQZTVWV0dm?=
 =?utf-8?B?TlZyTTRKeTZ2R1RWVFpoOXpoaWdoeVJCNWJtQlNoZzdXU2hjOGFuRmZtT3Fa?=
 =?utf-8?B?OEVlUmdMU0RDYnExa1NqcXJzb2JrYVhOOEduMW9INnU0M3h5SVpsMFNZVktM?=
 =?utf-8?B?QUVnMEJqZ2dqNGlYeEd6NmJiUWo1YlNJSEt6WjlFb0VidTRvTkRQalFIRkJs?=
 =?utf-8?B?OFdhU3hCVGdySFVzbkcvNElVV2hqTWFjUTF2ZnY1K0hxbTMvZlNxejluellM?=
 =?utf-8?B?L1VXbXN1UDJMK256WkNxYUFXd2lUTzFZZ1h1amF6OUgxeEFHaGZEcFNNSjZ6?=
 =?utf-8?B?d2JDZVcxN3hGbzBEamowM2RveXErb0hSVkJtWm9tYVk2a2ZhS1FHZnR6eHlK?=
 =?utf-8?B?QVBWWTFiVzBOb3dLQXhWbXVzK3JtUjI4UVV4NTBvUU9ZYTdvaVFuUXRvcXQ4?=
 =?utf-8?B?dWYyNU1HdzFENGYxSExCRC9qcVJFcmFRWG5EOGpocXpVR3N2N0s4bkNkSnZD?=
 =?utf-8?B?dHNweVFFajEwd20vaDhVdTFTbVVCS2tyMVJlOEozZGI2dWxueHFONFR3Ym5i?=
 =?utf-8?B?eTlWd280d3NiSlVQYk9qRnI5UkRzd3Y4OVFVRkdudnZQVVQ0VEdETmkvWGdU?=
 =?utf-8?B?Z29lSS9aYVAyenlaUU9QdXpGOURBRC8vVExzVkE2ZXJEdW1RdUVsdDVEMjM5?=
 =?utf-8?B?K3o1TEY2emhVdXE2VkJuMytGNFM5eHhlZCt1dEt4Q0NmYkNzWUNlL1JlZUtY?=
 =?utf-8?B?bHRxL3hydXJhN01mbUx4U09NbCt1eXB4Q1IveEJNWmxxN0poVUJpdW1ldUZG?=
 =?utf-8?Q?Aa1O2u645jLWk8QQDEeO+r0xC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13cc447-864e-482e-a2cd-08dab60a15c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 21:52:45.7523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /lXi0XzCrFEq9vXeDYS8sG/HE+4WMMHjxAHrSlwdnvif7Jl2DeQ3Sxyoo8LllZd/t5vdohY/ERxPTlNLL2sJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBJIG1pc3NlZCB0aGUgcHJlLXBlbmRlZCBsZW5ndGggYml0IC4uLiB3aXRoIHRoYXQgaXQgYWxs
IG1ha2VzIHNlbnNlLg0KDQpUaG91Z2ggdGhlIG90aGVyIHBsYWNlIHdoZXJlIG1jZSByZWNvcmRz
IGFyZSB2aXNpYmxlIHRvIHVzZXIgc3BhY2UNCmlzIGluIHRyYWNlIHJlY29yZHMuIFNlZToNCg0K
ICAgIGluY2x1ZGUvdHJhY2UvZXZlbnRzL21jZS5oDQoNCihOLkIuIHRoaXMgbmVlZHMgYW4gdXBk
YXRlIHRvIGluY2x1ZGUgdGhlIHBwaW4gYW5kIG1pY3JvY29kZSBmaWVsZHMpLg0KDQpJZiB0aGVz
ZSBuZXcgZmllbGRzIG5lZWQgdG8gYmUgaW4gdGhlIHRyYWNlIGxvZywgYW5kIHdlIHdhbnQgdG8g
bWFrZQ0KaXQgZWFzeSB0byBleHRlbmQsIHRoZW4gaGF2ZSB0byBmaWd1cmUgb3V0IGhvdyB0byBo
YW5kbGUgdGhpcyBpbiBhIHdheQ0KdGhhdCBkb2Vzbid0IGNvbmZ1c2UgYXBwbGljYXRpb25zIChy
YXNkYWVtb24gLi4uIGFyZSB0aGVyZSBvdGhlcnMpDQp0aGF0IGNvbnN1bWUgdGhlIHRyYWNlIHJl
Y29yZHMuDQoNCi1Ub255DQo=
