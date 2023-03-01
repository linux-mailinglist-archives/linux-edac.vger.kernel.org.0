Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69366A75A6
	for <lists+linux-edac@lfdr.de>; Wed,  1 Mar 2023 21:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCAU4p (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Mar 2023 15:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCAU4p (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 1 Mar 2023 15:56:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A15D4AFD4;
        Wed,  1 Mar 2023 12:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677704204; x=1709240204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wRJm1niuQw6mmufZDs73OavUjOSU7w5YcvvYC40kr/M=;
  b=Qu1uozsqyZw0W6PTeLJrk9Ms+cYW5Z8qS9DZWlCcWufPxMft/EKW+FbZ
   bOWmWFmPZCHNN/A5lrxF0NBnuzz+DswOE9c6wAJSVOMPoJfGcdUkAX+2f
   ON/Vn9pnPAQgjRhPyi9fHYSxwvb+s+UojCYk0apUcJ05R8L8xEb3XrVu7
   lFXkSy/upD4NhwPWcnXBKNrsW61qx9+yMtpveBAmq3+HLSBaARos6Z7Y+
   0pYViJb8IRgPPsH7uJBRTondmXWlCC7877NBfop7vCIpCwBSz09lMEjok
   0WZy9fbEsoj+ViEYHqMSi36t0nXGv4a1Fi7NLPPu2INWcXuwjkYjCLb8A
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="318321175"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="318321175"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 12:56:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="704987603"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="704987603"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 01 Mar 2023 12:56:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 12:56:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 12:56:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 12:56:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AckoAohvT+Bh67NKPBzcaV8DIoSm24/fYbjPJk1KvHlhpVn32BTOLvx3NP0H1MVYaEMPeh78nWoIEZmQnXjCoqq3vQLhpXrg4H9ZPWf+ehnAp84QUcWYgCU7BitbiS4AK6AZDTliyWRVtjc7nkvXah2abYODHkev1CNs8Y8KaYrS2Ky/nl1k2ZYGz/VhbJjmzso+5M38OSlrz6sgSRAFgXwfZaD3zhKVvHu77MsuwWTFQIxYAL8UBSvqggmYzpzs213mH/KeeEyNw3IDqK+wiaXjIwquyNYMNt1jCnyiBvR1+fxcE7bTfhhrc5tvHOmRtjg1CNUEtI1HIb0u7jWmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRJm1niuQw6mmufZDs73OavUjOSU7w5YcvvYC40kr/M=;
 b=oW6mDNeXEDAo9ijKdoFXwAy0nKbiJbFLi69K47LqGXPaqSEgCUzosoN/1kat6co5L24rFF9PdO0Sj8p6dzgJS0HKgPCv+fAnLSrtadcxj5w/g/tq/fshRxhttO+2j9qgIDsGaDY/7lCPy0JhQrGKAdJ45f27hc+w2gTf3uXEcjOiBvNitD1Ab2+J1MDVHtZoIPwg9Fci9HDnjNxbJ7kub+BHKq3GdRpYzliNWqelLUxqfFAqT1Arsl/4KOic8F7TH290G5ShGsFP3T+iYoYhWAGcmE3fZwIeeSiST2ZoORcM/vr53oEmxiZriuq+Dvfyx+ecGghMF7OTmSjIw26VtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BY1PR11MB8078.namprd11.prod.outlook.com (2603:10b6:a03:52a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 20:56:32 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6134.026; Wed, 1 Mar 2023
 20:56:32 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/mce: Schedule work after restart from sysfs update
Thread-Topic: [PATCH] x86/mce: Schedule work after restart from sysfs update
Thread-Index: AQHZTHwp6/B+CVvoMEGf1Hvcfvytt67mZyJA
Date:   Wed, 1 Mar 2023 20:56:32 +0000
Message-ID: <SJ1PR11MB60836DFF088E54BB770D1638FCAD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230301202623.2092271-1-yazen.ghannam@amd.com>
In-Reply-To: <20230301202623.2092271-1-yazen.ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BY1PR11MB8078:EE_
x-ms-office365-filtering-correlation-id: ffd67192-0f60-4eda-4454-08db1a976ffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MyQZ1Iw4suU5uoLexQyEfC8DQkrFUimWmMsAmhEQ9im5okHrbhOhyCidkYo7F2VlemfbW5F2jQqj4+AwjHIcVhGp9tHCrFT0eDxqDgeoW5gufOnW/q0bVIo8W+K/OmhcPD8qGp4BvrsCO17/ERkeHEfvj9AAQ2zNHXwDLHa7Bn08vVeiRkV6mITj3RuzqMkGMIXwhJYbfKpa2kk52S717twneqLeymvgUFt44vjPn3cBWxBPFb+e+/f7V/BkVjoLgWHJjDer7vs6Ox6beA5X2sC3qZnZAJsSJffWq4KkfnwjTBkSONezyWyQp1AiiBVsaFW3aFLDF7SA0fFiYIQ0luU3v/GkEoFk++qUfBi5a0aZ+8GmNMIlyqPxk7fa/Au6FKiHrU/bt5hva5YfaXV8o0lvWm9ELDlC8/4Am0x2l+BWx+Iz45HkqdSNr2lP2ItAdIy3/IrsTm3UoHRIdE8xBRlZBZvk765Y0Az+z9gequhOeuyIDjg4K9hpf0ir+0NafdtUUL/zsKJV0V+tLjzjQx3KAjAZwqYuX/FucoOn3I6xqdbzoOVAVhi8/Kvb0DWTm/grAH5I5MhBelK6N6YUjwNj+NSWNHfLrJP51FpFA/cTwrZU+FucT81KUhCjj5tfr6r7PDKJlqXJxenGdH8oeyvczr4/b/4J06n5pkZFAwvp6ZZShGBDmWjs9hes+V5VvwTB4v0+Ufoi62JyLTNb/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199018)(33656002)(6506007)(9686003)(186003)(26005)(316002)(41300700001)(110136005)(54906003)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(8676002)(15650500001)(7696005)(2906002)(52536014)(71200400001)(8936002)(5660300002)(478600001)(82960400001)(122000001)(38100700002)(86362001)(55016003)(558084003)(38070700005)(83380400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IHbnPnrb1V/jovoAnAUSKeKifeIoU0TYA7VfA091AuAMOEhd6GU4NsqsGU97?=
 =?us-ascii?Q?Nr80e4xWNzqj+ZA5epr5JiK5wAnqMGcE4mgsX6P13VbJ/KYYyP01K/RZdzWo?=
 =?us-ascii?Q?gox6r6Z9ZusCELD7Z4vV8sMAh/p7QWldvcjCLejsnZ0Vo3MD+kBew+eGWO2R?=
 =?us-ascii?Q?OsDlE5iSc+9eoMy+FEdh8Dt1Dee+hvBgd2ZnL9yCxH8NWGv5MxoWGBipYOgM?=
 =?us-ascii?Q?YxAX8Y0pE2oeqNLZnMfboka/gvMcbvonzzesWy/ECCFwKuv7upWThqpyTlHx?=
 =?us-ascii?Q?lWj9/O5fQVfjiS490dcU7z3I8Og83wCEtjr5zyeAbFnMS1DmkE9waBDusYoD?=
 =?us-ascii?Q?9De8yxlPIrn0PjXZlOGg3ltEpInS+Y/+wvwCOauhO/rCMQvQI6d4jUK0B2Z8?=
 =?us-ascii?Q?BrcfG1cXxLr2koGHuh7jOM1Nmj8cd2XVXuy7ZaC9n/YTaXIDeGVliESWR6AS?=
 =?us-ascii?Q?7T249d6OyR10Q43YCAbylIpdr+xSMDj8KaFpJnl0Uo70RgqGz2RkPq6H5+f6?=
 =?us-ascii?Q?aCTwl+Wz2xAkuuFKZH223ryRfWDNFvmRjiqauu1jV3FL6QLUhlJHY9kPeTN6?=
 =?us-ascii?Q?Q17Sd33CQq6QSVxe1SMlIQUYluyxv5Qrde4WiqHbgQeDwYUNmT865KXBUMt2?=
 =?us-ascii?Q?zY3ZSkhauM0hcOByugj860eU2HXOiSwhfjc3eTicJSJvIhyxlqIQzrTsLM06?=
 =?us-ascii?Q?25RKss+vOoHP038IPN66Z/WmEqF/J0QwSJWidFhIORelcmmfEzx2xaoMVSZc?=
 =?us-ascii?Q?hSCkf2R0VM7p856ALT1hlFxPnAA3OPS6uxOFAlQxt8RlalCAE05ba+RkFi0l?=
 =?us-ascii?Q?A9bxLyhFjUsDeB6B4erH8Pk2K0ThE4wVEU2Zy/EhRULcRcW4Z/MtUC/GkR7K?=
 =?us-ascii?Q?PmsKpFZOMQvra9JSpEwqaXYQINdtYVg39rgmZs5X9oV1tTDUlRiMCklkhLZK?=
 =?us-ascii?Q?XXUUjN/QLfQE4CrbSSeR50iArX+cWdxFDXNPePrM5AUhWuNHTDzIMwe7L2U9?=
 =?us-ascii?Q?rNwx9Yxli395ORcazg9Yy/rbNNFYrtjVmhOGXFjhMDtnSTzvQDZFRnkhFfGk?=
 =?us-ascii?Q?TTAyQZx/htWhYR5UxumVPIy6BZj9gURoBdM879Su4p2bprodoaX/2SfNts4s?=
 =?us-ascii?Q?MBItQar9rLz2ghQGZh6Oo/+ysjDs8CSKdyDRcNj70AheiwzrX3Ax7U4Ts/A/?=
 =?us-ascii?Q?a6Lmd8/VWKjkukP6ex5QZhsD3CWjMoc1j/MMMU80brBgg8M3mh4YrURB+FV5?=
 =?us-ascii?Q?uvRD+fDgHc5jvxshes4aFefdVRFNaajHSceJdCXfSVmPO5jq9fhuouHfHLhI?=
 =?us-ascii?Q?9ZSJ1guu6Fd/pLk0Snn8RDJds99HUw4Z+B0oGKcwvQbeTyA/gn/16+EKMEQ+?=
 =?us-ascii?Q?UAnwV4nxakTxQZ+JBFZjycR1WD2ZMJF6640Ewo9IK5HA+iB+Mj+RVafmVqy9?=
 =?us-ascii?Q?hOhmeLcGHe+T8LgXAOTC3oJVPclVb3ZJJrA7qZE7H3XRYKIkkGXPf15q+Wz9?=
 =?us-ascii?Q?gEm1Hhy7VUHPqXmAubhZE+tQmp6yju2R+0DZa2raGSJsniNeb/2Uo7mmlqnQ?=
 =?us-ascii?Q?3bGOdsSKEgsvdEyNEyDawBUixno04t8kRqninM5Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd67192-0f60-4eda-4454-08db1a976ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 20:56:32.3841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNUnpixoaeVId/sig9kNQihdZxOKEq39/8wKgVWYKnpwZoQyuxWBqqq5LR3o4Uf6GE6vebWf2bXqdJELHEKaYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8078
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> A number of sysfs updates call mce_cpu_restart() which goes through a

I think that should say "call mce_restart()"

-Tony
