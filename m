Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F84473A6E6
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jun 2023 19:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFVRFe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jun 2023 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFVRFd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jun 2023 13:05:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472FB10F1;
        Thu, 22 Jun 2023 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687453532; x=1718989532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xtV3EQ0PXLQE9bHa2kaRCLXDU4Smj+XkZzW0/suK6uc=;
  b=ZmhfLQSjN0pp9Kbz3qbWbEDffWPRkWBabWBzOvJVt2SuGyhOmFQYy8ga
   AyXgzCwZxe5co+eS65KeI75qtwiZW2vidZbksEJqm7fI9/qHaozG6fzUy
   gSbdpZhW6d/TIpjkJh4tqOcv3DpgQRQpAsVx6JMOJiZdE/t9jZSeytDpQ
   iRnLWXf9v2XIriyTGSbZbx76ZVMuK4twceZOjFh3a9B5+Q4p9U7xQr2VN
   waAuvtknwQk+zAVytyUwzQrKJeiTjcC5TQXTW3Nqv7OHy1EEAvTQ4VaVC
   McbmA5ElPXGriIQGEPOXq43bxlcuQtbWCCQYw+44k5b5nJVroyu/NnHHo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340154734"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340154734"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 10:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="804898873"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="804898873"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2023 10:05:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 10:05:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 10:05:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 10:05:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 10:05:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU3E+15/OHDMlk2DwYvKSKZ4xvRjJkaZyNfmlGzUnyfGuuxcPIeoDiiCgHx7mYlkTvynh2zBCcNW8ZlEMjIg1hOS0XUvdcXi2a39EmruO6N3r8aBkjqVxv4MQIWcNrHASGOgBDGYSoqd5oqvz7dGOTojdeyWmKPRXWlJ+3dWWW/WKhlwZWh/jzciBWNAmlW3kW99fUNNFzol5KMKkCWvOFiFxZwhiUyJfCRa6PSoZpnyyhusdu5H5NnHIhSEz4Xio9nTMWsGYhfnnf9mKGh3XnnXT9Yjv+4gzQ0+bwoYhqP5nbP+PDc9+ZEuo1ahzPjiYVQ+C7ik6zT4x+nqgktWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtV3EQ0PXLQE9bHa2kaRCLXDU4Smj+XkZzW0/suK6uc=;
 b=I4TMNBJfIAivjLFTI8/cGA+JIJjeIEiWYFSJEDp2MJfPbsTmw57xZ3hpY78GgJbDlb+JI7CEl+TWWE0Ds9uAOvw+drFqEtiHzcUqo+ab2mD50gb1cofA1msYOwTe1KrsIY3tiTabnvGv0LeSy3odgGYzpSMUOhZH1iv/8chZg9ZFwIEeDp7EMagqz8jyebhHQgqmfC+VLrWG2iDErAEkRkXgZAlpVS9MjxXU6wZxYXB3b+24u+J0Z1I3hjjht9+YRa6Zcr2fvtMvd/HmBbNWB/IV3Fned06bPGnarLEeSN6jd8bD237bUC5BVPuKBwrxKP48U+Ho+Oivd751ZTg5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6845.namprd11.prod.outlook.com (2603:10b6:806:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 17:05:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 17:05:24 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Thread-Topic: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Thread-Index: AQHZpQwiSV5YEcM40EuivrL9zu2Y2a+W8n2QgAAPY4CAAAqHsA==
Date:   Thu, 22 Jun 2023 17:05:24 +0000
Message-ID: <SJ1PR11MB6083961DFCA3D90922824189FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230622131841.3153672-1-yazen.ghannam@amd.com>
 <20230622131841.3153672-2-yazen.ghannam@amd.com>
 <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f03b6c61-1669-c03e-310c-cc1364cf30a8@amd.com>
In-Reply-To: <f03b6c61-1669-c03e-310c-cc1364cf30a8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6845:EE_
x-ms-office365-filtering-correlation-id: d7712621-98c9-4ec5-ce73-08db7342deaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s7MF6kxn/5gISixMqSjCbid485wGprArM3scxiPfJ/pOQAFzUnQ191XUn9nHyyeM1t1Y/HDMTbXWM5VBHvxAzyTupI1fhB7vN/urIZhzDmq5BbWrj/qKc7Hmhg1izWe7UloMihWiCmDfgd7n9sWp9DXbQ5a3KYbzZ/e/GJrgQZRP2Srt7SE/KMShCpD99fIYQBng9D9L2w/gtayCs357uiT2TngaAnHy6I/3CNXBO9Qyo7QSDH+1FXKs+2OqMhZiwih0KpDUBNApHxrdTB9ByKnqiCpOa1LlXT6yzGKCxjLcCHL71Zw2NheuEUg/tzmVdvTySPLyMzKEUENHusnAMzweWTMzTw0c1uSZqxHClo9BBxYvBUGHzvqbdPUzb9HGf/VVLzGrIA2RYVywB/29UqSS9FttXdCMC1SnjrLTtFT1PzdRU3pLoSWjJ33KmWih4SdJ3VPHhPv3uDvybyQzk9Th0qdOHQhrckTUeZRDDZOzZMMlO5gK5SsPl8x+X/Z5Dawi4j6frHeegxcZdppgKB9cO++Nex43XIqt7h7/UxG3JELA0k4FEoQZJ4Z1k6ueoQg9vTELe7up++sbJ0Cg6NIicBRINDbVQfTL3yt7V9cFBP1Z2JYgd7FlwUr05b+6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(82960400001)(38100700002)(122000001)(55016003)(54906003)(4744005)(71200400001)(478600001)(7696005)(2906002)(52536014)(64756008)(5660300002)(76116006)(66946007)(316002)(66556008)(66446008)(66476007)(41300700001)(4326008)(8676002)(8936002)(83380400001)(110136005)(9686003)(186003)(6506007)(26005)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c01YT0VvVHhRQklmSE5oRk14dHVlYmxnRHFoNWJBRW4rTkJlWjYrZDVoaXVv?=
 =?utf-8?B?OWI3c0xsd055aFl5ejkzZDVqZTB1eGdQSDVoajZYZXRNK1Zxc1gwblJQcDU1?=
 =?utf-8?B?RHhOVTg1T21WcXpMd2IzUkU0b1JEc3ZObmp5cHZVckRHc2w2b1ZPWlIzMzVa?=
 =?utf-8?B?QVdZRzZTcVpuQ25rYU4vOFUvRS9DVG5nR3R2c0QvdjBQOGhBdjEwUURoVThl?=
 =?utf-8?B?Z0UvMVJtV1lhVUFMSEVoOTAyR3BaWDZMa1ZLK1BrelcvMVVMdkRJSU1SOHJO?=
 =?utf-8?B?bU9LeGdOa3pYZndVN1JoWGR1UUNheFN4TTZ6WlJMa0VYSGtQUUZsdER6ZDY3?=
 =?utf-8?B?MWVNL0t1L01VTEdvZFJhYVpHQ0xSL1JKK25uR0phdzFZVEF5WlNDc0VXQnNX?=
 =?utf-8?B?ejErZDF2eDU1akFHcjI4TERVMEp4ZXk1cjlJVDhmM2ZaS3BFTGd6RERBRkZG?=
 =?utf-8?B?UE9BUUEzbmdUZlhVOFA4dmFVbGtWUmRnRDZVTlprVnRHMFcxaEVwTVVIZkRx?=
 =?utf-8?B?MDBhd09uN0dlaUF4NWNvcEtzK1Rhc2tJRk5xYTV3cDgwRFlMVElVQ0JDZWdX?=
 =?utf-8?B?YlBNS1RuR2F6N3A5V1dWNGpORnRtZmcwZWpNSklmenBkcWtjVStnK0JEbmps?=
 =?utf-8?B?cTVEWmgzU0Joc3kyT0YvQUFIK0MzNDlZV3J2WERLT012YVNGcnE2L09NaU1u?=
 =?utf-8?B?RzQxVFN5TFc2MitIUFdncWhJWnNWSnozSmkvV0FMSUxNY3N1U0NvMFk3V0s2?=
 =?utf-8?B?RDAwYk1NYXFET0R1LzdnMmExWkhDSjdwNXkvSVpwaTRtQmw3UFFaNXoyZzRY?=
 =?utf-8?B?cE9YcCtKb3c0SGQ3c3JyazFYM1AyTUN2cWdwNzFKMjRxUzlUdTA2VkFaWkVD?=
 =?utf-8?B?dzlaK3NiNmZKZUFtV0U5Mks1cmEzd0s3UXNtT01BUXJXb1hJWnZaMjhiQnJj?=
 =?utf-8?B?NU9lWlpKalBSNWdtMTFhT3FjdkVjb0xmRGdoQldVTFptaTNGZjRFQzFkVWEv?=
 =?utf-8?B?R3Brb3c3QkNnWHZnanRQNndESzB5VXNIT1d5TVl0dXJiemxlNStUaktTWEx4?=
 =?utf-8?B?TjFBUFRvdHhkS3habi9BQlF5bEdzMUJ1MndVRkN6bDlQYmdvK0dsQlBLQjlN?=
 =?utf-8?B?aC94T1E1T0ZuNnliWXhIbEphN3B2U2ZXb3JUb3E1eE9lNUFtOHJ1dGU1dXor?=
 =?utf-8?B?M0pCNVZveE42Rlp2eHg1amxxY2NGOUpobkM3K0hVR0RGSWQ4Rlc2THZjd2hF?=
 =?utf-8?B?eGNoeHE4SEJmRjdlbVcvemVyL3Z1Mm84RDlsdnJmMUlEZEZhL0wwUFl5UjZF?=
 =?utf-8?B?YXAyWW5Nb2srT3ExUDZZSEZZdTJOQUwwU0lNaUQrUzlhK3lWTEFITjJxWm40?=
 =?utf-8?B?TzVqWGNsOGY4dDFpM05IRlVkRVg3RTdqR1hvWHJDZG9sVWdLcjlvdm5pUkNa?=
 =?utf-8?B?OFFQZ1g1L0xEZXVCeTd5dXJHUktYOW1jdHZJUTNrMjhFYUFscHJtQUhsdjl3?=
 =?utf-8?B?TS93azh1cWtid1RjVFkxdDlZVjFtNk1zNVJ0Y1lEMDlRcEQrTjkzelFNNDRl?=
 =?utf-8?B?dk8xVVZPL2hoK2tvN2FrZ2F3dzJVNVpqdU5ia0ZrdXNHUEMrQW1reGZGME9F?=
 =?utf-8?B?WTdQM1JwdS9RYVFBS0w5N0t0ZHRmU09PODV1YURMOHFoQktBSG5yaUVyblhB?=
 =?utf-8?B?V043Q2dyd3hJMW9yQ0Zja2ZpcmtOMTdFVGMzdElVQzZLQjlJcmVlOVJObjNy?=
 =?utf-8?B?QkM4Y09uRHprOHBobVpXbTI2TUFUQmhJbE42K0J1dVlOUmJEM2psMnllSldP?=
 =?utf-8?B?YlRNR2ZGa1cxTkMvNUh1VjUvUHluM1NPR0o4MGZrL3JWcitCUHdPZTZBbUE5?=
 =?utf-8?B?ZGVpQVNYTnNJM0pPK0VVV1laYnJ4QzdsZy9ERWQvbUhHY2kySk5aallSQk45?=
 =?utf-8?B?TUJWdThWQk5mTXBvd0w0OW9QMDZWTkpkUEVnZFJidUJGV2F3cytlZ3F6c3Zl?=
 =?utf-8?B?YXBDZENyRm5uL3ZYdTlxSVQ3Slk4Y08xcGYrcDFFVHlFYWxTMXNxSUs5RHZ5?=
 =?utf-8?B?bkJ6OFFEM1BZZkZ6Z1MybG00R0ovbkhqRkl1amxUV2JUTHNsMDNjc1MyZXZn?=
 =?utf-8?Q?xVuw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7712621-98c9-4ec5-ce73-08db7342deaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:05:24.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPly8dU+8LSYvHKtlagEQdWstdQ9ndlLTaxNY8fCEROxh75fizU0lDW8T7h4/Au/pX84q5DrVmHigiiQkdje0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6845
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBUaGlzIGlzIHRoZSByZWFzb24gd2Ugc2VhcmNoIGZvciB0aGUgbG9naWNhbCBDUFUgbnVtYmVy
IHVzaW5nIHRoZSBMb2NhbCANCj4gQVBJQyBJRCBwcm92aWRlZCBpbiB0aGUgQ1BFUi4gQW5kIGZp
bGwgaW4gcmVsZXZhbnQgZGF0YSB1c2luZyB0aGF0IENQVSANCj4gbnVtYmVyLg0KDQpTbyB5b3Ug
ZG9uJ3QgY2FyZSB3aGljaCBDUFUgbnVtYmVyIG1jZV9zZXR1cCgpIHVzZWQgYmVjYXVzZSB5b3Ug
YXJlDQpnb2luZyB0byB1cGRhdGUgaXQgd2l0aCB0aGUgcmlnaHQgb25lIGZyb20gQ1BFUj8NCg0K
VGhlbiBtYXliZSB0aGUgZml4IGZvciBwYXJ0IDEgaXMganVzdCB0byB1c2UgcmF3X3NtcF9wcm9j
ZXNzb3JfaWQoKSBpbnN0ZWFkIG9mDQpzbXBfcHJvY2Vzc29yX2lkKCkgdG8gYXZvaWQgdGhlIHdh
cm5pbmcgZm9yIGNhbGxpbmcgd2l0aCBwcmUtZW1wdGlvbiBlbmFibGVkLA0KaW5zdGVhZCBvZiBk
aXNhYmxpbmcgcHJlbXB0aW9uIHdpdGggdGhlIGdldF9jcHUoKSAuLi4gcHV0X2NwdSgpIHdyYXAg
YXJvdW5kIHRoZQ0KY2FsbCB0byBtY2Vfc2V0dXAoKT8NCg0KLVRvbnkNCg==
