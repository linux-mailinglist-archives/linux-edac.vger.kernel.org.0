Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B556C202373
	for <lists+linux-edac@lfdr.de>; Sat, 20 Jun 2020 13:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgFTL72 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 20 Jun 2020 07:59:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727983AbgFTL71 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 20 Jun 2020 07:59:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A8740A2861F0A33F643B;
        Sat, 20 Jun 2020 19:59:25 +0800 (CST)
Received: from [10.166.214.20] (10.166.214.20) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 20 Jun 2020 19:59:15 +0800
Subject: Re: [PATCH 2/2] rasdaemon: add support for memory Corrected Error
 predictive failure analysis
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <guanyalong@huawei.com>,
        <wuyun.wu@huawei.com>, <tanxiaofei@huawei.com>
References: <1590740663-6664-1-git-send-email-lvying6@huawei.com>
 <1590740663-6664-3-git-send-email-lvying6@huawei.com>
 <20200529163106.347dbd0f@coco.lan>
From:   lvying <lvying6@huawei.com>
Message-ID: <55d1379d-f349-2562-ba57-7bffd4c705bf@huawei.com>
Date:   Sat, 20 Jun 2020 19:59:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200529163106.347dbd0f@coco.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.214.20]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>> diff --git a/misc/rasdaemon.env b/misc/rasdaemon.env
>> new file mode 100644
>> index 0000000..0c05af0
>> --- /dev/null
>> +++ b/misc/rasdaemon.env
>> @@ -0,0 +1,29 @@
>> +# Page Isolation
>> +# Note: Run-time configuration is unsupported, service restart needed.
> 
> 
>> +# Note: this file should be installed at /etc/sysconfig/rasdaemon
> 
> If so, be sure to add it to Makefile.am, at "install-data-local"
> target.
> 
> It would also be nice if you patch could touch[1]:
> 
> 	misc/rasdaemon.spec.in
> 
> [1] I'll end doing this if your patch series doesn't, as
>      my release scripts depend on having it built into
>      Fedora rawhide, as I want to ensure that all build
>      time dependencies are properly mapped - at least at the
>      *.spec file.
> 

OK, I add %install and %files content:
%install
...
install -D -p -m 0644 misc/rasdaemon.env 
%{buildroot}%{_sysconfdir}/sysconfig/%{name}
...
%file
...
%config(noreplace) %{_sysconfdir}/sysconfig/%{name}
...
Also, I will add instructions for use into man file.

>> +
>> +# Specify the threshold of isolating buggy pages.
>> +#
>> +# Format:
>> +#   [0-9]+[unit]
> 
> 
>> +# WARNING: please make sure perfectly match this format.
> 
> I would improve the parser and remove this warning.
> 

the parser can handle exception input cases. This message is ambiguous.
Just like this:
# Notice: please make sure match this format, rasdaemon will use default 
value for exception input cases.

>> diff --git a/ras-events.c b/ras-events.c
>> index 511c93d..c034f6c 100644
>> --- a/ras-events.c
>> +++ b/ras-events.c
>> @@ -798,6 +798,9 @@ int handle_ras_events(int record_events)
>>   	ras->page_size = page_size;
>>   	ras->record_events = record_events;
>>   
> 
> 
>> +	/* FIXME: enable memory isolation unconditionally */
>> +	ras_page_account_init();
>> +
> 
> As I commented on patch 1, I'd like to be able to allow building
> rasdaemon with a feature subset.
> 

Ok, I rewrite:
#ifdef HAVE_MEMORY_CE_PFA
     /* FIXME: enable memory isolation unconditionally */
     ras_page_account_init();
#endif

>>   
>> +	/* Account page corrected errors */
>> +	if (!strcmp(ev.error_type, "Corrected"))
>> +		ras_record_page_error(ev.address, ev.error_count, now);
>> +
> 
> Same here: the code should be called only if the predictive
> failure analysis feature is enabled, e. g.:
> 
> 	#ifdef HAVE_feature_name
> 		/* Account page corrected errors */
> 		if (!strcmp(ev.error_type, "Corrected"))
> 			ras_record_page_error(ev.address, ev.error_count, now);
> 
> 	#endif
> 
Ok, I use same macro "HAVE_MEMORY_CE_PFA" here.

> 
> Instead of a goto-based loop, could you please change the code to use
> a normal loop?
> 

Ok, I will use less goto-based loop to make this code logic clearly, 
maybe only use goto-base loop to handle exception case.

> E. g. Something like:
> 
> 	do {
> 		done = try_set_isolation_env();
> 	} while(!done);
> 
>> +	/* Start a new round */
>> +	no_unit = unit_matched = 0;
> 
> Nitpick: Please place one statement per line, e. g.:
> 
> 	no_unit = 0;
> 	unit_patched = 0;

OK, I will follow this rule

> 
>> +
>> +	/* Environments could be un-configured */
>> +	if (!env || !strlen(env))
>> +		goto use_default;
> 
> Could you please verify if your code won't have endless loops?
> 
> On a first glance, it seems that, if env is zero, the loop
> will run forever.

No, when the env is zero, it will use default env value:
if (sscanf(env, "%lu", &value) < 1 || !value)
	goto use_default;

> 
>> +
>> +	/* Index of the last char of environment */
>> +	last = strlen(env) - 1;
>> +	unit = env + last;
>> +	if (isdigit(*unit)) {
>> +		unit = config->unit;
>> +		no_unit = 1;
>> +	}
> 
> I guess you need to add:
> 
> 	} else {
> 		last--;
> 	}
> 

No need here, this place just judge whether the env has valid unit, if 
not use the default unit.

>> +
>> +	/* Only decimal digit can be accepted */
>> +	for (i = 0; i < last; i++) {
>> +		if (!isdigit(env[i]))
>> +			goto use_default;
>> +	}
> 
> .. as the last character won't be a digit if no_unit == 0.
> 

It doesn't matter, here only check the characters before the last 
character are all digit.

> 
> Btw, after re-reading this code a couple of times, I guess this logic
> could be re-written on a different way, with should avoid the reparse
> loop and making it simpler for reviewers to analyze it (code untested):
> 
> 	static int parse_isolation_env(struct isolation *config)
> 	{
> 		char *env = getenv(config->name), *unit = NULL;
> 		unsigned long value;
> 		char *s[255];
> 		int len;
> 
> 		strncpy(s, env, sizeof(s));
> 		s[255] = '\0';
> 
> 		len = strlen(s);
> 
> 		if (!isdigit(s[len - 1])) {
> 			for (units = config->units; units->name; units++) {
> 				if (!strcasecmp(&s[len - 1], units->name)) {
> 					unit = units->val;
> 					break;
> 				}
> 			}
> 
> 			/* Return error if the unit is unknown */
> 
> 			if (!unit)
> 				return -1;
> 			else
> 				s[len - 1] = '\0';
> 		}
> 
> 		/* Return error if value is not valid or if it is zero */
> 		if (sscanf(s, "%lu", &value) < 1 || !value)
> 			return -1;
> 
> 		value *= unit->val;
> 	
> 		config->env = env;
> 		config->val = value;
> 		config->unit = unit ? unit : "";
> 
> 		return 0;
> 	}		
> 
> Btw, instead of setting a default, I would instead print some error message,
> as some action will need to be taken in order to avoid parsing it wrongly.

And I rewrite this function and reduce the reparse goto-base statement 
to make it clearly. The first part to check if env characters are valid. 
The second part to parse the env value(if not valid use the default value):

static void parse_isolation_env(struct isolation *config)
{
     char *env = getenv(config->name);
     char *unit = NULL;
     const struct config *units = NULL;
     int i, no_unit;
     int valid = 0;
     int unit_matched = 0;
     unsigned long value, tmp;

     /* check if env is vaild */
     if (env && strlen(env)) {
         /* All the character before unit must be digit */
         for (i = 0; i < strlen(env) - 1; i++) {
             if (!isdigit(env[i]))
                 goto parse;
         }
         if (sscanf(env, "%lu", &value) < 1 || !value)
             goto parse;
         /* check if the unit is vaild */
         unit = env + strlen(env) - 1;
         /* no unit, all the character are value character */
         if (isdigit(*unit)) {
             valid = 1;
             no_unit = 1;
             goto parse;
         }
         for (units = config->units; units->name; units++) {
             /* value character and unit character are both valid */
             if (!strcasecmp(unit, units->name)) {
                 valid = 1;
                 no_unit = 0;
                 break;
             }
         }
     }

parse:
     /* if invalid, use default env */
     if (valid) {
         config->env = env;
         if (!no_unit)
             config->unit = unit;
     } else {
          log(TERM, LOG_INFO, "Improper %s, set to default %s.\n",
                  config->name, config->env);
     }

     /* if env value string is greater than ulong_max, truncate the last 
digit */
     sscanf(config->env, "%lu", &value);
     for (units = config->units; units->name; units++) {
         if (!strcasecmp(config->unit, units->name))
             unit_matched = 1;
         if (unit_matched) {
             tmp = value;
             value *= units->val;
             if (tmp != 0 && value / tmp != units->val)
                 config->overflow = true;
         }
     }
     config->val = value;
     /* In order to output value and unit perfectly */
     config->unit = no_unit ? config->unit : "";
}

I will send patch version2 to give more detail about env parse.

>> +	if (period >= cycle.val) {
>> +		/**
>> +		 * Since we don't refresh automatically, it is possible that the period
>> +		 * between two occurences longer than the pre-configured refresh cycle.
> 
> Nitpick:
> 		longer than -> will be longer than
> 
Ok, I will fix it


>> +	pr->count += count;
>> +	if (pr->count >= threshold.val) {
>> +		log(TERM, LOG_INFO, "Corrected Errors at %#llx exceed threshold\n", pr->addr);
> 
> Nitpick:
> 	exceed -> exceeded
> 
Ok, I will fix it


> 
> Thanks,
> Mauro
> .
> 


-- 
Thanks!
Lv Ying
