Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C05A1C2609
	for <lists+linux-edac@lfdr.de>; Sat,  2 May 2020 16:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgEBOSb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 2 May 2020 10:18:31 -0400
Received: from mail-co1nam11on2041.outbound.protection.outlook.com ([40.107.220.41]:6018
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727996AbgEBOSa (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 2 May 2020 10:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M31/B6QXkgO1z7ADbjENsrRiImaJ1znP8q4AOkBptz0RSPche38Z2nJEr/zWyd0mPUPLHwCRki6t/CEJvNG3BZxGVqGXBTYC6daOOVTeRJFoeCJXKCPBiEyR1e/NLI9zkQla9XsjZSN9DmmNAoNVnqzux+OqNZykCovCw5UBYSaRy/XXqYFL+rGgJrjSkkyZY5iHeWQlPcWGfKR3Ezye2W2X546+QbCIY5lTcnfaifdXcfCj2T24pdDrX9a9dPllwDMvhayJiZM+E1/B7TJrvo375GAL9yTic5CV0U50aWgePKrd7SXBtRHQXsG5CkwsGWpr42LGnPy9TV2XKLiEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKVOGiJEiXl5FK2Vxq5anwBxPyMiA+uQcbRiTqhHPPo=;
 b=JbRcu6vTO6TnCYVqrp/Q4BLwi/wkTWkdeHTQPsTosU+9xnkymKiQhOi529rlGypEaRxN3YNOFKTp7R4p4HlJt7FCPlJchKjYOhaoDeAwJ8ZINLn7F1Hqw2B68VDQL07KaZkdyIhOCnF+y4GBV8sCF+K1u7ME3fsEHEIii9GP+sUuZGCzWz4v3MAOClWWYHjViO2IBL1QJGx+ejdz8eWj/pSnRHYNbAPCFkp9QbsFSCtWlWapB47TwrCzLUSP51xvLuUCqHK0cKWv8gTgWp6plOMOsVFUXk7n4kaM/ESIifye6gN+h3Dh/oeWSpoG1DXPy9PphxF8mfJ7HMsfWN/aCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKVOGiJEiXl5FK2Vxq5anwBxPyMiA+uQcbRiTqhHPPo=;
 b=eDZoXEfoB3NKk8j3zhnkqUpGpXCW7uKjbwNnV4CnVTMRC1NbPRuC9q9S3TSlBZpMMv70ghJ+ov/jR8e1lTNfI4hCGGDTmp0SG3OfQxJQJvRxW4OQ9lYBrLwZm0zt/Ps6ME25muByfQ875BmY+NQG3CqFkGBlzrRKqZPI91zLEb4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2767.namprd11.prod.outlook.com (2603:10b6:805:5a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 2 May
 2020 14:18:28 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::75b1:da01:9747:ae65]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::75b1:da01:9747:ae65%4]) with mapi id 15.20.2937.028; Sat, 2 May 2020
 14:18:28 +0000
Subject: Re: [PATCH] x86/mce: Add compat_ioctl assignment to make it
 compatible with 32-bit system
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1583303947-49858-1-git-send-email-zhe.he@windriver.com>
 <1f449e01-3207-b699-b91f-d1c04626a447@windriver.com>
 <20200427181903.GA14473@agluck-desk2.amr.corp.intel.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <38398607-c47f-fa3c-9325-5941b4fb7162@windriver.com>
Date:   Sat, 2 May 2020 22:18:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200427181903.GA14473@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HKAPR04CA0014.apcprd04.prod.outlook.com (2603:1096:203:d0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 14:18:25 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 319ecd90-a7b3-4ce6-81b3-08d7eea3aed6
X-MS-TrafficTypeDiagnostic: SN6PR11MB2767:
X-Microsoft-Antispam-PRVS: <SN6PR11MB2767E77A284E3464C98B15E78FA80@SN6PR11MB2767.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 039178EF4A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3360.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39840400004)(346002)(376002)(2616005)(36756003)(8936002)(6916009)(52116002)(478600001)(4326008)(16526019)(8676002)(6706004)(2906002)(956004)(6486002)(31686004)(186003)(26005)(6666004)(16576012)(316002)(31696002)(86362001)(5660300002)(53546011)(66946007)(66476007)(66556008)(78286006);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIit8aJfJNfGpWKZSQ3Bqu2uA3DPGGOuK3r/mdlOFdPdHUjm0Y4sZKUZiiGKS9qFSlTml2lB1p5Ev2AkJo1mAsbbggF2xChtbcw+xFg2tRpjReeIq7zgVRiofx74KKSgCPoDR3BHieT4/f20DUIFWz0KOlnjz4YZoRNClVeU8Xh5lxeSulYso0PZNkoCXa1WFoHrRQNEyXtzW/HrZYcsyq00OawbZeqAn8c29/gbsFRHmOTIC7xUv6CyjOvw/6vaP0hH/QFRTQf+az7+6bNjbXa/asnQTEuay8Fb3WnwqIbF6yOuqazs38qpCeAKBs5IDJ3t5QTzs33H05rmc9zWEjgdvrFO5nU0b5wHqC1pOjlCW54Wmchdx+T6UwUJOuFoiSIlsQZQ0vRajkptQnIG2zWREXaFj42VUDgcuTl7K3VL1RfRGCAwEcNokyE6ihdRP4iuL/pHl1GNSKHJqedCu8C055zemPVQcXhsAsOfI5SSqyRO5bJHFBokfWlKPRxqcujajFxMGKZVLkGMrLiaUOVQQd0GxVAvQG3Y+Pv3m5Y=
X-MS-Exchange-AntiSpam-MessageData: wyzOMF+Vfot2e62oVjQsdHB7DiRxao17RGB8AUDIj0adOdS+fw7iCiDno7odhDcUsowtk61TV9ipFbicvDtTQ9Bi0XqeRcaWjO2AlLHcPsVhQZAha58aqHxeRtHn3AukJY3vgWsP6Cww/Gqvneff4W21b0BopoZQGOM7bWh2yTZOBlYl/zRPMN21fhtjqmGLvP92/VHUjQbc6XPAQdzn/MOyLGoIKTblr8lysyiVXOnSXJg8XGxufrGNKdKWfss0M8lWZkCOz9DgOSJ1BA+63eRFVd9XIwtTI5d9c3LFEslDH/w5Rj5r5cngp+6oj6i8Lxjbwh6n7FjORw5b6lXNQX/doUbu4PKsOFeVmgye33Rbe5+0YUoaNzNaoDaPQRFc4oGwCMReqwjoJO1f570MBlXd1Bz+NQnXRwrmpNSg171ZSkjppC46P8ooxhkW7Fv8rwoA4gJPKZAV0VbkoZxi8W51CaFoRIfuprpVBXGOrdYnoBRw8jk1zWH56sdT8vZRbGgE7ZvajFhnbUazLTZ6a6xWdWI/1kfpK93NAltcTr0yknINvekqNl4AZ6pdNh6UK1qz/HorZJ1/U27Dzzx1VRnwZBXD/0Ux1kLxLkal7chypGaK3VuwcBmAfTWk3fY+i+f4+RHCdVucOASWWmxVNVSVsHHZmwM1mDtNVIuxqTnzd6zsRa9nM7veO/ZMvORl55aODSEjZBIKS27ICUoUAAA+ZpkFXiKG3CO+AY4Y7DFOZZQTP6Yx6xoi2dDuu7LX1CLKUIVouboKhO+b6nBCJGWNruYqbgnyrJ/rxwXhOyk=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319ecd90-a7b3-4ce6-81b3-08d7eea3aed6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 14:18:27.9796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x74DTsmjKyKsVls0/jflLrdKghBiH3ClaSkGOjQRWseTm7tPdLL0/XTR5od5sAlYohlHGOxXPiJEmfwhfZqnKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2767
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 4/28/20 2:19 AM, Luck, Tony wrote:
> On Thu, Apr 16, 2020 at 04:40:31PM +0800, He Zhe wrote:
>> Can this be considered for the moment?
>>
>> Thanks,
>> Zhe
>>
>> On 3/4/20 2:39 PM, zhe.he@windriver.com wrote:
>>> From: He Zhe <zhe.he@windriver.com>
>>>
>>> 32-bit user-space program would get errors like the following from ioctl
>>> syscall due to missing compat_ioctl.
>>> MCE_GET_RECORD_LEN: Inappropriate ioctl for device
>>>
>>> compat_ptr_ioctl is provided as a generic implementation of .compat_ioctl
>>> file operation to ioctl functions that either ignore the argument or pass
>>> a pointer to a compatible data type.
> I'm not super-familiar with the compat ioctl bits.  But this looks plausible.
>
> All three of the ioctl's for this driver have a "pointer to integer" for the
> "return" value.  And "int" is a compatible type between i386 and x86_64.
>
> I don't have a system setup to build a 32-bit binary to test the theory,
> but I assume that you have built something that tests all three:
>
> 	MCE_GET_RECORD_LEN
> 	MCE_GET_LOG_LEN
> 	MCE_GETCLEAR_FLAGS
>
> So I guess:
>
> Acked-by: Tony Luck <tony.luck@intel.com>

Thanks, and yes, I had tested all three.

Zhe

>
>>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>>> ---
>>>  arch/x86/kernel/cpu/mce/dev-mcelog.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
>>> index 7c8958d..6c9b91b7 100644
>>> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
>>> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
>>> @@ -328,6 +328,7 @@ static const struct file_operations mce_chrdev_ops = {
>>>  	.write			= mce_chrdev_write,
>>>  	.poll			= mce_chrdev_poll,
>>>  	.unlocked_ioctl		= mce_chrdev_ioctl,
>>> +	.compat_ioctl		= compat_ptr_ioctl,
>>>  	.llseek			= no_llseek,
>>>  };
>>>  

