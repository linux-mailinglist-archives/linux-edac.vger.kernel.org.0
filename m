Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21C26D5111
	for <lists+linux-edac@lfdr.de>; Mon,  3 Apr 2023 21:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjDCTD4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Apr 2023 15:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjDCTDz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Apr 2023 15:03:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB972268E;
        Mon,  3 Apr 2023 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680548634; x=1712084634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IcxKhVmTn1+y90fcU6NGSpnVWSXokVc8eMUpEzlMbkQ=;
  b=crZHpmtVgG2MzVelhnNMMmgZbrxHsAb4X1w23zmnbhm5a3BUlfNNcbUr
   HFTKU+QvzB1Eb208AScHFp6PTPwPMkVxUiPNpWNOqgS1nH/hdJT7V8kmc
   A+Tt5Lpa3ikMefZCxDurSJ2oByK8ipJHskhnSGle9LnNEatMp+89Ikk5N
   aDTJRv0U2hdJ175RRaiIaljVo9+ZbngXE66FJGQrhokSrf1gbYS3VX9JY
   De/oXSbvjXEC1RAcLA7U3UVoUzIKNyCAj43n8746A2/jlyTkizGBoOke3
   KYj/3ygQQjEogC25XfV1ILxs/nWm+o6veFkK4jbNR6atRn3QGs0OGJu0D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="321651225"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="321651225"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 12:03:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="1015826478"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="1015826478"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 03 Apr 2023 12:03:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 12:03:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 12:03:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 12:03:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 12:03:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDUAbconAfDaWtBGsNmuf2z8xmkEwU8pwk6/Jard0uO1zgavOcZJJFuwteOC4qtLtvuLDB2lLOuRVmTMvBxcJlJBmrtjDy3oAkO0oXl39mmKujgaArHVmkWOlo57uw6Fpkg36abK1aGhvpG9tKy24lYrpQTuuVbDvkg6VfdciBAVrJhi9VQ3FADkraFps0WofgZsF3fwyHaeVhFvOi0YysdcvSJqWuZvqN24QPQnbDhwvaMH7yJodBfosqCMGV7o6w6IJQFjPxVOOnCYaFJOZjIm/iAKFcUFiZWjCKuBxJF7Um0UcCKQACugK1MGbUs7wrAEHW/w1gsGC/gyOmjf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcxKhVmTn1+y90fcU6NGSpnVWSXokVc8eMUpEzlMbkQ=;
 b=Vv41Uvn7JpmMzgARqZdwVQs3Kzf2L3e5Smupi1XKupskJ2broG+UwCjuaDNaYwGfR5bUOVEPg7Yd5PHDw+nCV4dsYcN9lMIsVk2xP2E3pR2bA3pml4BEmEg3OwusPEoNVIpBcZf6vOokXJPu4SphIVXGYpw35CivbXjmVzkArrMJxlzLZT8hrduf0Xnj59lIWZIIVMn9qVH9wsM2w16Iy3p3s0ADq/d/p93n7iV87rIX3BoSjYh/Y683ZiWZMND2WRdJNj0cbRi3690SrNj6HFBaSy/bR9n427FIoBmwHqvKWxGWA6XgJGfQNe8DW/1+7thmJy2DnKwSXpwRp2D6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BY1PR11MB8080.namprd11.prod.outlook.com (2603:10b6:a03:528::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 19:03:36 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5%7]) with mapi id 15.20.6254.024; Mon, 3 Apr 2023
 19:03:36 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v3 4/5] x86/mce: Move storm handling to core.
Thread-Topic: [PATCH v3 4/5] x86/mce: Move storm handling to core.
Thread-Index: AQHZWPTgJ4wIXq7BtEGVPo9uGmSDaK8IhfAAgAArnhCAACa0kIAJG26AgAgX+oA=
Date:   Mon, 3 Apr 2023 19:03:36 +0000
Message-ID: <SJ1PR11MB608315F2F50BFEDF8D01C76FFC929@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
 <20230317172042.117201-1-tony.luck@intel.com>
 <20230317172042.117201-5-tony.luck@intel.com>
 <ZBxvyqb5Mnt13341@yaz-khff.amd.com>
 <SJ1PR11MB60835D7F85097FEF454DD74CFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083D33BC6860AB9FE2A292BFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZCRYl9c7xgIJ+pJe@yaz-sghr>
In-Reply-To: <ZCRYl9c7xgIJ+pJe@yaz-sghr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BY1PR11MB8080:EE_
x-ms-office365-filtering-correlation-id: 752863ee-e1b2-43b0-b694-08db347620b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBD/qbUV8/0F3J5rw/GlmSKrC+yG3IB0/c78PXbrfftFc5/HdATS4EX/inFk6N+HrS3qKEHDsRuDWZmrxYbt+0gX8s4xKw7P7bbNQ1RobBNuM3vsHyRte4ursq1wqn8ql9RQmnt8KgZ5MR8WXD2Y8h6zOUVuThzYCFirzq9XcRYkNuWEUKhfgeb17U1hcXHFPw9zR9QIa0Mb1qCKslU0nvMBqROGGEK3m4moJGpwL2F4K9io0C49u+R/l+y1HDAPmObMxuVuYPGqN52oKwdy4154JtXbNDbpFbJnClOTrwtScIU1wVYzqvj8sdjyPzz+vZ27Z3zGCicmoF4C8YqbI4dclNW1lcKNf70DXCvVCbPiTwt8t2gnKXnJDIeoNTfvPpIdBhykro6F57PMS+tjehIuC3MaIFdmWMq28AvaGziDUSNfQShL4X/Lhh0z4xufUtYg86f2SD2rKVAuxHUbGLtSrgMiGeDQrV0+OpgZLVq7KUfHb3W2thj/ikIspre9gE2f7XQ8Rfufzc3EQfyt0TfQLs/6BJ1aLosJQZbhV6yZ5bT7pAz1A6XkWy5BPzBrvPOOVNFXRf2V2L5q2GPDdf6dggEpEwrLQc0t+T66Hs7xsHc9lFO0MtAHTx9sdAe1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(38070700005)(558084003)(33656002)(2906002)(55016003)(7696005)(71200400001)(186003)(9686003)(6506007)(26005)(4326008)(8676002)(478600001)(66946007)(66556008)(76116006)(66446008)(6916009)(66476007)(64756008)(122000001)(82960400001)(41300700001)(38100700002)(5660300002)(52536014)(316002)(54906003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UiAW4KJXaSomCXViFjmADYlRS5kCOf9uRBhzkBWpLQFy1LRzMjduywh6Kblh?=
 =?us-ascii?Q?b+LQmzbfWFpo31oNNWpwsECBr8PBMxYQ9RXypMhFbKztwTW//xAg5ZfemdeN?=
 =?us-ascii?Q?Ewaf/LrZ/9tt1Xei2Du7crtwWQVOXgaqJPXFgyIRITUo/Ubs89JMVThYuDAN?=
 =?us-ascii?Q?bUzbZZIIwrk4XumFAGytb3uKRFyqd7m3PB8YYK6vXV+/+W3vxb1bdFB6XLgN?=
 =?us-ascii?Q?oamyNONlpP1J81lwz2PGD0OLoY8YY98XDrC1IM0Dl5W1ePEZpduoX7mIEhJn?=
 =?us-ascii?Q?yWlCHfsxUbLJxB1Lk27mlZ4i/oMAclf394SGGKzmFIrt4NuDsjUuey/VfD0D?=
 =?us-ascii?Q?8EP6OEL5EBYEnv4My7Mnlt86GereGF1E096FDS7xo8M+3TSLo3OPX7Tr08Jx?=
 =?us-ascii?Q?7l0fPemJCssmh7ujzcNUrmnlv8gdfcu2eKLHZYtivs2VoNwEnhSj01m8CqyD?=
 =?us-ascii?Q?r3a/Cvjz/kj6dRDT6of68skfjtfte8+Jzwjva95BaKVbttqlgNXIFthENEhc?=
 =?us-ascii?Q?rBMipPdxPa+4TYZNSHWMFHzvjqMVjKvXiYlZvZrNocQuo/IGkuHTQg/5pNQg?=
 =?us-ascii?Q?GAZLAWZbiGo5JluGXZ5EOzorQPjZj1YQqPcXNw5AFzT9XVyeTVNz/DCnxBuc?=
 =?us-ascii?Q?UTnrQvLblJVSkL4vRJZ9N3h6EdTcF7w1YtGRO8g3JAEgkMxhBLqxSebGhVu/?=
 =?us-ascii?Q?qFS/4OgwbEs09NLZI1FuyIH9hl805EBFqFls862o+J3p5V6Qyn0tcg1wlvqW?=
 =?us-ascii?Q?ss8IPWbtPjtH6nbbMfvbaMcB4KH0AM7JJj8xxKA6CxmSl0ttQM0buiLbGwkG?=
 =?us-ascii?Q?Pxe4BIcHHrODx41RcMZlY2vmN4tS0/qhrioxRd1L8qhviXpCYGK2H5cGFZI8?=
 =?us-ascii?Q?O2B7Y9/jdsyK6+Xb/PKX4u7WRqOMhCLeXplvFBvgUD/1PXn/T8MMnpFoehiV?=
 =?us-ascii?Q?ReSGWijHzZHL/5p+h10nKmVxURc550J5bzKnHVuy0BdkpEkLqPmXBWsa4CNq?=
 =?us-ascii?Q?WqbfMXZSjdPtK5KxqjKdwEPXkrbZf3EqlVBnLPB4rWE81a+IAXZ9XQov4EvI?=
 =?us-ascii?Q?ZkpGX22n2B2V10u0/SBRS9qd1kxayHNOCtiwiyBJu4Z0zu2e/TwYWkTz5qBf?=
 =?us-ascii?Q?uvxniXT9VIEHEOLgJVq0oMQnlAXUFndWD0og2wWuDeDNNrKv1ECZZNrKdHsy?=
 =?us-ascii?Q?jcT4jbZRNT4Imwps19kU+MS+yy5zn5tpbmPdGStxjm3wJQpb8mYmywC1CIyH?=
 =?us-ascii?Q?beauoBnnWVVg6hA2tiOeunfdN3/pN6D0OSsESHqiwDhk7Qy9oAchCoFWqU50?=
 =?us-ascii?Q?AUK3Oc4wxpijiXHrzR4zDxdHSMmNwvLsoRbFiAgVx6IQv0LTLb04IELXWrlC?=
 =?us-ascii?Q?VhotvrWhNSBcvApaurzgxwFyuQKKDjz5ISSgybJaKJisZ7kTcSDpXZd7quPo?=
 =?us-ascii?Q?U3Apo7ckKu9HoZZ3cSM/y6X964XymgI6g+G81l2UwuFiWEDHwDeX0iyWE0M5?=
 =?us-ascii?Q?bTQo5mcMSzScBbXHNwHwahsGXB15JXW2feoHDqBFEXnLXf/xqR5DHkGpqBR/?=
 =?us-ascii?Q?7/1o0ipSU4PNEf69Bes=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752863ee-e1b2-43b0-b694-08db347620b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 19:03:36.1957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQ0DDbT82d93K+1RKiKtqFAMIeFnzrF15E934TqjBs/Kdkcf7ti9tWvsPr/ooL7gS6EPCAGMTdqEd2A6epzKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8080
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Hi Tony,
>
> Builds, boots, and passes my tests here too.
>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>

Yazen,

Thanks. I'll add your tags and post a v4 to the mailing list for Boris to r=
eview.

-Tony
